<template>
  <div class="kg-container">
    <div class="kg-toolbar">
      <div class="search-form">
        <el-form :inline="true" size="small">
          <el-form-item label="检索类型">
            <el-select v-model="search.mode" style="width: 140px">
              <el-option label="节点" value="node" />
              <el-option label="组(父节点)" value="group" />
            </el-select>
          </el-form-item>
          <el-form-item label="关键字">
            <el-input
              v-model="search.keyword"
              placeholder="名称/关系/组名"
              @keyup.enter.native="doSearch"
              style="width: 260px"
            />
          </el-form-item>
          <el-button type="primary" @click="doSearch">查询</el-button>
          <el-button @click="resetView">重置</el-button>
        </el-form>
        <div class="tool-row">
          <el-upload
            action="#"
            :show-file-list="false"
            :before-upload="beforeImport"
          >
            <el-button type="primary">导入</el-button>
          </el-upload>
          <el-button @click="exportJSON" type="primary">导出</el-button>
          <el-button type="primary" @click="openStatsDialog"
            >统计图谱特征</el-button
          >
        </div>
      </div>
    </div>

    <el-dialog
      title="图谱数据特征统计"
      :visible.sync="statsDialogVisible"
      width="620px"
      @opened="renderStatsPie"
      @close="disposeStatsPie"
    >
      <div ref="statsPieRef" style="width: 100%; height: 360px"></div>
    </el-dialog>

    <div class="kg-main">
      <div class="kg-graph" ref="graphRef"></div>
    </div>

    <!-- 知识卡片推荐抽屉 -->
    <el-drawer
      title="节点详情"
      :visible.sync="recDrawerVisible"
      direction="rtl"
      size="380px"
    >
      <div class="kg-side">
        <div class="panel" v-if="selectedNode">
          <el-descriptions
            :title="selectedNode.name"
            :column="1"
            size="small"
            border
          >
            <el-descriptions-item label="类型">{{
              selectedNode.categoryName
            }}</el-descriptions-item>

            <el-descriptions-item label="描述">{{
              selectedNode.description || "-"
            }}</el-descriptions-item>
            <el-descriptions-item label="属性">
              <pre class="props-json">{{ pretty(selectedNode.props) }}</pre>
            </el-descriptions-item>
          </el-descriptions>
        </div>
        <el-card
          v-for="rec in recommendations"
          :key="'rec-' + rec.id"
          class="rec-card"
        >
          <div class="rec-title ellipsis">{{ rec.name }}</div>
          <div class="rec-desc">{{ rec.description || "—" }}</div>
        </el-card>
      </div>
    </el-drawer>
  </div>
</template>

<script>
import * as echarts from "echarts";
require("echarts/theme/macarons");

export default {
  name: "KnowledgeGraph",
  data() {
    return {
      chart: null,
      raw: {
        nodes: [],
        links: [],
        categories: [],
      },
      view: {
        nodes: [],
        links: [],
        categories: [],
      },
      stats: {
        nodeCount: 0,
        categoryCount: 0,
        linkCount: 0,
        tripleCount: 0,
      },
      selectedNode: null,
      recommendations: [],
      search: {
        mode: "group",
        keyword: "",
      },
      colorPalette: [
        "#5470C6",
        "#91CC75",
        "#EE6666",
        "#73C0DE",
        "#3BA272",
        "#FC8452",
        "#9A60B4",
        "#EA7CCC",
        "#fac858",
        "#2f4554",
      ],
      statsDialogVisible: false,
      statsPie: null,
      edgeColorMap: {},
      edgePalette: [
        "#67C23A",
        "#E6A23C",
        "#F56C6C",
        "#409EFF",
        "#909399",
        "#9A60B4",
        "#3BA272",
        "#FC8452",
        "#d48265",
        "#61a0a8",
      ],
      recDrawerVisible: false,
    };
  },
  mounted() {
    this.initChart();
    this.loadDemo();
    window.addEventListener("resize", this.resizeChart);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.resizeChart);
    if (this.chart) {
      this.chart.dispose();
      this.chart = null;
    }
    this.disposeStatsPie();
  },
  methods: {
    initChart() {
      if (this.chart) return;
      this.chart = echarts.init(this.$refs.graphRef, "macarons");
      this.chart.on("click", (params) => {
        if (params.dataType === "node") {
          const nodeId = params.data.id;
          const node = this.view.nodes.find((n) => n.id === nodeId);
          this.onNodeClick(node);
        }
      });
      this.renderGraph();
    },
    resizeChart() {
      if (this.chart) this.chart.resize();
      if (this.statsPie) this.statsPie.resize();
    },
    renderGraph() {
      const option = {
        tooltip: {
          trigger: "item",
          formatter: (params) => {
            if (params.dataType === "node") {
              return `${params.data.name}<br/>类型：${
                params.data.categoryName || "-"
              }\n`;
            }
            if (params.dataType === "edge") {
              return "";
            }
            return "";
          },
        },
        series: [
          {
            type: "graph",
            layout: "force",
            roam: true,
            draggable: true,
            focusNodeAdjacency: true,
            symbol: "circle",
            symbolSize: (value, params) => {
              if (params && params.data && params.data.isGroupParent) return 60;
              const base = 36;
              const deg = (params && params.data && params.data.degree) || 0;
              return Math.max(18, Math.min(56, base + deg * 2));
            },
            force: { repulsion: 220, edgeLength: [60, 150] },
            categories: this.view.categories,
            data: this.view.nodes,
            links: this.view.links,
            edgeSymbol: ["none", "none"],
          },
        ],
      };
      this.chart && this.chart.setOption(option, true);
      this.computeStats();
    },
    computeStats() {
      this.stats.nodeCount = this.view.nodes.length;
      this.stats.linkCount = this.view.links.length;
      this.stats.tripleCount = this.view.links.length;
      const catSet = new Set(
        this.view.nodes.map((n) => n.categoryName || "未分类")
      );
      this.stats.categoryCount = catSet.size;
    },
    openStatsDialog() {
      this.statsDialogVisible = true;
    },
    disposeStatsPie() {
      if (this.statsPie) {
        this.statsPie.dispose();
        this.statsPie = null;
      }
    },
    renderStatsPie() {
      if (!this.$refs.statsPieRef) return;
      if (!this.statsPie) {
        this.statsPie = echarts.init(this.$refs.statsPieRef, "macarons");
      }
      const totalNodes = this.raw.nodes.length;
      const totalLinks = this.raw.links.length;
      const totalCats = new Set(
        this.raw.nodes.map((n) => n.categoryName || "未分类")
      ).size;
      const totalTriples = totalLinks;
      const items = [
        { name: "节点", value: totalNodes, icon: "circle" },
        { name: "类型", value: totalCats, icon: "rect" },
        { name: "关系", value: totalLinks, icon: "triangle" },
        { name: "三元组", value: totalTriples, icon: "diamond" },
      ];
      const colors = [
        this.colorPalette[0],
        this.colorPalette[1],
        this.colorPalette[2],
        this.colorPalette[3],
      ];
      const option = {
        color: colors,
        tooltip: { trigger: "item", formatter: "{b}: {c} ({d}%)" },
        legend: {
          orient: "vertical",
          right: 10,
          top: "center",
          data: items.map((i) => ({ name: i.name, icon: i.icon })),
        },
        series: [
          {
            name: "图谱特征",
            type: "pie",
            radius: ["40%", "70%"],
            center: ["40%", "50%"],
            avoidLabelOverlap: true,
            label: { formatter: "{b}: {c}" },
            labelLine: { smooth: true },
            data: items.map((i, idx) => ({
              name: i.name,
              value: i.value,
              itemStyle: { color: colors[idx] },
            })),
          },
        ],
      };
      this.statsPie.setOption(option, true);
    },
    pretty(obj) {
      if (!obj) return "-";
      try {
        return JSON.stringify(obj, null, 2);
      } catch (e) {
        return String(obj);
      }
    },
    onNodeClick(node) {
      this.selectedNode = node;
      this.recommendations = this.recommendFor(node);
      this.recDrawerVisible = this.recommendations.length > 0;
    },
    handleDrawerClose() {
      this.drawerVisible = false;
      this.selectedNode = null;
      this.recommendations = [];
    },
    recommendFor(node) {
      if (!node) return [];
      const neighborIds = new Set(
        this.view.links
          .filter((l) => l.source === node.id || l.target === node.id)
          .flatMap((l) => [l.source, l.target])
      );
      neighborIds.delete(node.id);
      const neighbors = this.view.nodes.filter((n) => neighborIds.has(n.id));
      const ruleMap = {
        电压互感器: ["电流互感器"],
        断路器: ["继电保护", "重合闸动作"],
        变压器: ["母线", "保护装置", "传感器"],
      };
      let ruleCandidates = [];
      if (ruleMap[node.name]) {
        ruleCandidates = this.view.nodes.filter((n) =>
          ruleMap[node.name].includes(n.name)
        );
      }
      const sameCategory = this.view.nodes.filter(
        (n) => n.categoryName === node.categoryName && n.id !== node.id
      );
      const pool = [
        ...new Set([...neighbors, ...ruleCandidates, ...sameCategory]),
      ];
      return pool.slice(0, 8);
    },
    edgeColorByType(type) {
      const key = type || "关联";
      if (key === "属于") return "rgba(170,170,170,.55)";
      if (!this.edgeColorMap[key]) {
        const idx = Object.keys(this.edgeColorMap).length;
        this.edgeColorMap[key] =
          this.edgePalette[idx % this.edgePalette.length];
      }
      return this.edgeColorMap[key];
    },
    edgeWidthByType(type) {
      const t = type || "";
      if (t === "属于") return 1;
      if (["接入", "控制", "连接", "联动", "切换"].includes(t)) return 2.6;
      if (["上传", "产生", "采集", "触发", "关联", "调节", "诊断"].includes(t))
        return 2.2;
      return 1.8;
    },
    getReadableTextColor(hex) {
      const rgb = this.hexToRgb(hex || "#000000");
      const L = 0.299 * rgb.r + 0.587 * rgb.g + 0.114 * rgb.b;
      return L > 160 ? "#333" : "#fff";
    },
    hexToRgb(hex) {
      let h = (hex || "").replace("#", "");
      if (h.length === 3)
        h = h
          .split("")
          .map((c) => c + c)
          .join("");
      const num = parseInt(h || "000000", 16);
      return { r: (num >> 16) & 255, g: (num >> 8) & 255, b: num & 255 };
    },
    setViewFromRaw(filterFn = null) {
      const nodes = filterFn
        ? this.raw.nodes.filter(filterFn)
        : [...this.raw.nodes];
      const idSet = new Set(nodes.map((n) => n.id));
      const links = this.raw.links.filter(
        (l) => idSet.has(l.source) && idSet.has(l.target)
      );
      const degreeMap = new Map();
      links.forEach((l) => {
        degreeMap.set(l.source, (degreeMap.get(l.source) || 0) + 1);
        degreeMap.set(l.target, (degreeMap.get(l.target) || 0) + 1);
      });
      nodes.forEach((n) => {
        n.degree = degreeMap.get(n.id) || 0;
      });

      this.view = {
        nodes,
        links,
        categories: [...this.raw.categories],
      };
      this.renderGraph();
    },
    resetView() {
      this.setViewFromRaw();
      this.selectedNode = null;
      this.recommendations = [];
      this.recDrawerVisible = false;
    },
    doSearch() {
      const q = (this.search.keyword || "").trim();
      if (!q) {
        this.$message.warning("请输入关键字");
        return;
      }
      const qLower = q.toLowerCase();
      if (this.search.mode === "node") {
        this.setViewFromRaw(
          (n) =>
            (n.name || "").toLowerCase().includes(qLower) ||
            (n.description || "").toLowerCase().includes(qLower) ||
            (n.categoryName || "").toLowerCase().includes(qLower)
        );
      } else if (this.search.mode === "rel") {
        const matchedLinks = this.raw.links.filter((l) =>
          (l.label || "").toLowerCase().includes(qLower)
        );
        const idSet = new Set(
          matchedLinks.flatMap((l) => [l.source, l.target])
        );
        const nodes = this.raw.nodes.filter((n) => idSet.has(n.id));
        const categories = [...this.raw.categories];
        this.view = { nodes, links: matchedLinks, categories };
        this.renderGraph();
      } else if (this.search.mode === "group") {
        // Search by parent group (category) name, show all its child nodes
        this.setViewFromRaw((n) =>
          (n.categoryName || "").toLowerCase().includes(qLower)
        );
      }
    },

    // Import/Export JSON
    beforeImport(file) {
      const reader = new FileReader();
      reader.onload = () => {
        try {
          const json = JSON.parse(reader.result);
          this.ingestJSON(json);
          this.$message.success("导入成功");
        } catch (e) {
          console.error(e);
          this.$message.error("JSON 解析失败");
        }
      };
      reader.readAsText(file);
      return false;
    },
    ingestJSON(json) {
      if (Array.isArray(json)) {
        const nodes = [];
        const links = [];
        const categories = [];
        let catIndex = 0;
        json.forEach((groupObj) => {
          Object.keys(groupObj).forEach((groupName) => {
            const arr = groupObj[groupName] || [];
            const catName = groupName;
            const color =
              this.colorPalette[catIndex % this.colorPalette.length];
            const cat = { name: catName, itemStyle: { color } };
            categories.push(cat);
            const parentId = `${groupName}`;
            nodes.push({
              id: parentId,
              name: groupName,
              description: "分组",
              categoryName: catName,
              category: catIndex,
              props: { isGroupParent: true },
              isGroupParent: true,
              itemStyle: { color, borderColor: "#fff", borderWidth: 1.5 },
              label: {
                show: true,
                position: "inside",
                color: this.getReadableTextColor(color),
                fontWeight: 600,
              },
              symbol: "circle",
              symbolSize: 60,
            });
            arr.forEach((item) => {
              const id = `${groupName}-${item.index}`;
              nodes.push({
                id,
                name: item.name,
                description: item.value,
                categoryName: catName,
                category: catIndex,
                props: { index: item.index, group: groupName },
                itemStyle: { color, borderColor: "#fff", borderWidth: 1.5 },
                label: {
                  show: true,
                  position: "inside",
                  color: "#333",
                  fontWeight: 600,
                },
                symbol: "circle",
                symbolSize: 36,
              });
              links.push({
                source: parentId,
                target: id,
                label: "属于",
                lineStyle: {
                  color: "rgba(170,170,170,.55)",
                  width: 1,
                  curveness: 0.08,
                  opacity: 0.85,
                },
              });
            });
            catIndex += 1;
          });
        });
        this.raw = { nodes, links, categories };
        this.setViewFromRaw();
        return;
      }
      if (json && json.nodes && json.links) {
        // Normalize nodes
        const categories =
          json.categories && json.categories.length
            ? json.categories
            : this.deriveCategories(json.nodes);
        const catNameToIndex = new Map(categories.map((c, i) => [c.name, i]));
        const nodes = json.nodes.map((n) => {
          const catIndex =
            typeof n.category === "number"
              ? n.category
              : catNameToIndex.get(n.categoryName) || 0;
          const catColor =
            (categories[catIndex] &&
              categories[catIndex].itemStyle &&
              categories[catIndex].itemStyle.color) ||
            this.colorPalette[catIndex % this.colorPalette.length];
          return {
            id: n.id || n.name,
            name: n.name,
            description: n.description || n.value || "",
            categoryName:
              n.categoryName ||
              (categories[catIndex] && categories[catIndex].name) ||
              "未分类",
            category: catIndex,
            props: n.props || {},
            isGroupParent: n.isGroupParent || false,
            symbol: "circle",
            symbolSize: n.symbolSize || (n.isGroupParent ? 60 : 36),
            itemStyle: n.itemStyle || {
              color: catColor,
              borderColor: "#fff",
              borderWidth: 1.5,
            },
            label: n.label || {
              show: true,
              position: "inside",
              color: this.getReadableTextColor(catColor),
              fontWeight: 600,
            },
          };
        });
        // Normalize links
        const links = (json.links || []).map((l) => ({
          source: l.source,
          target: l.target,
          label: l.label || l.type || "",
          tooltip: { show: false },
        }));
        this.raw = { nodes, links, categories };
        this.setViewFromRaw();
        return;
      }
      throw new Error("不支持的 JSON 结构");
    },
    deriveCategories(nodes) {
      const catSet = Array.from(
        new Set(nodes.map((n) => n.categoryName || n.category || "未分类"))
      );
      return catSet.map((name, i) => ({
        name,
        itemStyle: { color: this.colorPalette[i % this.colorPalette.length] },
      }));
    },
    exportJSON() {
      // 直接导出 demo 数据
      const demo = [
        {
          设备: [
            {
              index: "1",
              name: "变压器",
              value: "电力系统电压变换的核心设备。",
            },
            {
              index: "2",
              name: "断路器",
              value: "通断电路并隔离故障的保护装置。",
            },
            {
              index: "3",
              name: "保护装置",
              value: "自动检测故障并触发保护动作的设备。",
            },
            {
              index: "4",
              name: "监控终端",
              value: "实时采集设备运行数据的智能终端。",
            },
            { index: "5", name: "母线", value: "汇集和分配电能的导体节点。" },
            {
              index: "6",
              name: "输电线路",
              value: "输送电能的架空线或电缆通道。",
            },
            {
              index: "7",
              name: "智能电表",
              value: "记录用户用电量并支持远程抄表的终端。",
            },
            {
              index: "8",
              name: "传感器",
              value: "监测温度、电流等物理量的感知设备。",
            },
          ],
        },
        {
          数据与状态: [
            {
              index: "1",
              name: "遥测数据",
              value: "远程采集的电压、电流等实时量测值。",
            },
            {
              index: "2",
              name: "遥信数据",
              value: "设备开关状态或告警信号的远程上报。",
            },
            {
              index: "3",
              name: "过载告警",
              value: "设备负荷超过安全阈值的预警信号。",
            },
            {
              index: "4",
              name: "跳闸事件",
              value: "保护装置触发断路器断开电路的记录。",
            },
            { index: "5", name: "运行状态", value: "设备正常供电的工作模式。" },
            { index: "6", name: "检修状态", value: "设备停机维护的标记状态。" },
            {
              index: "7",
              name: "电压越限",
              value: "电压超出允许范围的异常数据。",
            },
            {
              index: "8",
              name: "谐波畸变",
              value: "电流/电压波形失真的质量问题。",
            },
          ],
        },
        {
          故障事件: [
            {
              index: "1",
              name: "短路故障",
              value: "相间或对地异常低阻接通的故障。",
            },
            {
              index: "2",
              name: "接地故障",
              value: "线路或设备对地绝缘失效的事件。",
            },
            { index: "3", name: "停电事件", value: "供电中断的系统记录。" },
            {
              index: "4",
              name: "孤岛运行",
              value: "局部电网脱离主网独立运行的状态。",
            },
            {
              index: "5",
              name: "重合闸动作",
              value: "断路器跳闸后自动尝试合闸的操作。",
            },
          ],
        },
        {
          分析与控制: [
            {
              index: "1",
              name: "SCADA系统",
              value: "电网数据采集与监控的核心平台。",
            },
            {
              index: "2",
              name: "故障定位",
              value: "快速确定线路故障点位置的技术。",
            },
            {
              index: "3",
              name: "负荷预测",
              value: "基于历史数据预估未来用电需求。",
            },
            {
              index: "4",
              name: "拓扑分析",
              value: "动态计算电网连接关系的算法。",
            },
            {
              index: "5",
              name: "自动电压控制",
              value: "优化电网电压稳定的闭环调节。",
            },
          ],
        },
        {
          运维策略: [
            { index: "1", name: "调度指令", value: "调度中心下发的操作命令。" },
            {
              index: "2",
              name: "巡检计划",
              value: "定期检查设备状态的维护方案。",
            },
            {
              index: "3",
              name: "N-1准则",
              value: "单一设备故障不影响供电的安全标准。",
            },
            { index: "4", name: "黑启动", value: "大停电后系统自恢复的预案。" },
          ],
        },
        {
          标准与装置: [
            {
              index: "1",
              name: "IEC 61850",
              value: "电力自动化通信国际标准。",
            },
            {
              index: "2",
              name: "RTU",
              value: "远程终端单元，数据上传与指令执行设备。",
            },
            {
              index: "3",
              name: "PMU",
              value: "同步相量测量单元，高精度动态监测装置。",
            },
          ],
        },
        {
          保护与机制: [
            {
              index: "1",
              name: "继电保护",
              value: "故障时快速隔离设备的防御体系。",
            },
            {
              index: "2",
              name: "备自投",
              value: "备用电源自动投入的切换逻辑。",
            },
            {
              index: "3",
              name: "防误操作",
              value: "强制约束错误操作的联锁机制。",
            },
          ],
        },
        {
          运行指标: [
            {
              index: "1",
              name: "供电可靠性",
              value: "用户年均停电时间的评价指标。",
            },
            {
              index: "2",
              name: "线损率",
              value: "输电过程中电能损耗的百分比。",
            },
            {
              index: "3",
              name: "频率偏差",
              value: "电网实际频率与标准值的差值。",
            },
            {
              index: "4",
              name: "功率因数",
              value: "有功功率与视在功率的比值。",
            },
          ],
        },
      ];

      const blob = new Blob([JSON.stringify(demo, null, 2)], {
        type: "application/json",
      });
      const url = URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = "图谱数据.json";
      a.click();
      URL.revokeObjectURL(url);
      
      this.$message.success("已导出 demo 数据");
    },

    // Demo dataset based on provided domain terms
    loadDemo() {
      const demo = [
        {
          设备: [
            {
              index: "1",
              name: "变压器",
              value: "电力系统电压变换的核心设备。",
            },
            {
              index: "2",
              name: "断路器",
              value: "通断电路并隔离故障的保护装置。",
            },
            {
              index: "3",
              name: "保护装置",
              value: "自动检测故障并触发保护动作的设备。",
            },
            {
              index: "4",
              name: "监控终端",
              value: "实时采集设备运行数据的智能终端。",
            },
            { index: "5", name: "母线", value: "汇集和分配电能的导体节点。" },
            {
              index: "6",
              name: "输电线路",
              value: "输送电能的架空线或电缆通道。",
            },
            {
              index: "7",
              name: "智能电表",
              value: "记录用户用电量并支持远程抄表的终端。",
            },
            {
              index: "8",
              name: "传感器",
              value: "监测温度、电流等物理量的感知设备。",
            },
          ],
        },
        {
          数据与状态: [
            {
              index: "1",
              name: "遥测数据",
              value: "远程采集的电压、电流等实时量测值。",
            },
            {
              index: "2",
              name: "遥信数据",
              value: "设备开关状态或告警信号的远程上报。",
            },
            {
              index: "3",
              name: "过载告警",
              value: "设备负荷超过安全阈值的预警信号。",
            },
            {
              index: "4",
              name: "跳闸事件",
              value: "保护装置触发断路器断开电路的记录。",
            },
            { index: "5", name: "运行状态", value: "设备正常供电的工作模式。" },
            { index: "6", name: "检修状态", value: "设备停机维护的标记状态。" },
            {
              index: "7",
              name: "电压越限",
              value: "电压超出允许范围的异常数据。",
            },
            {
              index: "8",
              name: "谐波畸变",
              value: "电流/电压波形失真的质量问题。",
            },
          ],
        },
        {
          故障事件: [
            {
              index: "1",
              name: "短路故障",
              value: "相间或对地异常低阻接通的故障。",
            },
            {
              index: "2",
              name: "接地故障",
              value: "线路或设备对地绝缘失效的事件。",
            },
            { index: "3", name: "停电事件", value: "供电中断的系统记录。" },
            {
              index: "4",
              name: "孤岛运行",
              value: "局部电网脱离主网独立运行的状态。",
            },
            {
              index: "5",
              name: "重合闸动作",
              value: "断路器跳闸后自动尝试合闸的操作。",
            },
          ],
        },
        {
          分析与控制: [
            {
              index: "1",
              name: "SCADA系统",
              value: "电网数据采集与监控的核心平台。",
            },
            {
              index: "2",
              name: "故障定位",
              value: "快速确定线路故障点位置的技术。",
            },
            {
              index: "3",
              name: "负荷预测",
              value: "基于历史数据预估未来用电需求。",
            },
            {
              index: "4",
              name: "拓扑分析",
              value: "动态计算电网连接关系的算法。",
            },
            {
              index: "5",
              name: "自动电压控制",
              value: "优化电网电压稳定的闭环调节。",
            },
          ],
        },
        {
          运维策略: [
            { index: "1", name: "调度指令", value: "调度中心下发的操作命令。" },
            {
              index: "2",
              name: "巡检计划",
              value: "定期检查设备状态的维护方案。",
            },
            {
              index: "3",
              name: "N-1准则",
              value: "单一设备故障不影响供电的安全标准。",
            },
            { index: "4", name: "黑启动", value: "大停电后系统自恢复的预案。" },
          ],
        },
        {
          标准与装置: [
            {
              index: "1",
              name: "IEC 61850",
              value: "电力自动化通信国际标准。",
            },
            {
              index: "2",
              name: "RTU",
              value: "远程终端单元，数据上传与指令执行设备。",
            },
            {
              index: "3",
              name: "PMU",
              value: "同步相量测量单元，高精度动态监测装置。",
            },
          ],
        },
        {
          保护与机制: [
            {
              index: "1",
              name: "继电保护",
              value: "故障时快速隔离设备的防御体系。",
            },
            {
              index: "2",
              name: "备自投",
              value: "备用电源自动投入的切换逻辑。",
            },
            {
              index: "3",
              name: "防误操作",
              value: "强制约束错误操作的联锁机制。",
            },
          ],
        },
        {
          运行指标: [
            {
              index: "1",
              name: "供电可靠性",
              value: "用户年均停电时间的评价指标。",
            },
            {
              index: "2",
              name: "线损率",
              value: "输电过程中电能损耗的百分比。",
            },
            {
              index: "3",
              name: "频率偏差",
              value: "电网实际频率与标准值的差值。",
            },
            {
              index: "4",
              name: "功率因数",
              value: "有功功率与视在功率的比值。",
            },
          ],
        },
      ];
      this.ingestJSON(demo);

      this.setViewFromRaw();
    },
  },
};
</script>

<style lang="scss" scoped>
.kg-container {
  display: flex;
  flex-direction: column;
  height: 100%;
}
.kg-toolbar {
  padding: 10px 12px 0 12px;
}
.tool-row {
  margin-bottom: 6px;
  display: flex;
  gap: 10px;
}
.search-form {
  margin-bottom: 6px;
}
.stats {
  display: flex;
  gap: 12px;
  padding: 6px 0 10px 0;
}
.stat-item {
  background: #f5f7fa;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  padding: 6px 10px;
  display: inline-flex;
  align-items: baseline;
  gap: 6px;
}
.stat-item .label {
  color: #909399;
  font-size: 12px;
}
.stat-item .value {
  color: #303133;
  font-weight: 600;
}

.kg-main {
  display: flex;
  flex: 1;
  min-height: 480px;
  overflow: hidden;
}
.kg-graph {
  flex: 1;
  min-width: 0;
  height: calc(100vh - 220px);
}
.kg-side {
  width: 360px;
  border-left: 1px solid #ebeef5;
  padding: 10px;
  overflow: auto;
}
.drawer-content {
  padding: 16px 16px 0 16px;
}
.panel {
  margin-bottom: 12px;
}
.panel-title {
  font-weight: 600;
  margin-bottom: 8px;
}
.props-json {
  white-space: pre-wrap;
  background: #fafafa;
  border: 1px solid #eee;
  padding: 8px;
  border-radius: 4px;
}
.empty {
  color: #909399;
}
.rec-card {
  margin-bottom: 8px;
}
.rec-title {
  font-weight: 600;
}
.rec-title .cat {
  color: #909399;
  font-weight: 400;
}
.ellipsis {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>