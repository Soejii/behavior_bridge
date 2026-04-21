// Progress chart — rich line + area + goal line + schedule markers + color by goal
// Pure SVG, no deps. Accepts values, goal, schedule change indices, and tokens.

function ProgressChart({
  values,
  goal = 4,
  max,
  width = 360,
  height = 180,
  t,
  scheduleChanges = [], // indices (0-based) on the values array where a schedule was applied
  showDays = true,
  showGoalLabel = true,
  compact = false,
}) {
  const pad = compact ? { l: 28, r: 12, t: 14, b: 20 } : { l: 30, r: 14, t: 16, b: 24 };
  const plotW = width - pad.l - pad.r;
  const plotH = height - pad.t - pad.b;
  const maxY = max ?? Math.max(goal + 1, ...values) + 0.5;
  const minY = 0;
  const xAt = (i) => values.length <= 1 ? pad.l + plotW / 2 : pad.l + (i / (values.length - 1)) * plotW;
  const yAt = (v) => pad.t + plotH - ((v - minY) / (maxY - minY)) * plotH;
  const goalY = yAt(goal);

  // path strings — one full for stroke, two (below/above goal) for color fills
  const linePath = values.map((v, i) => (i ? 'L' : 'M') + xAt(i).toFixed(1) + ',' + yAt(v).toFixed(1)).join(' ');
  const areaPath = linePath + ` L ${xAt(values.length - 1).toFixed(1)},${(pad.t + plotH).toFixed(1)} L ${xAt(0).toFixed(1)},${(pad.t + plotH).toFixed(1)} Z`;

  // y grid lines
  const ySteps = [];
  for (let v = 0; v <= Math.ceil(maxY); v++) if (v % 2 === 0) ySteps.push(v);

  const accent = t.accent.stroke;
  const below = t.warn;
  const above = t.ok;

  const areaId = 'area-' + Math.random().toString(36).slice(2, 8);

  return (
    <svg width={width} height={height} style={{ display: 'block', overflow: 'visible' }}>
      <defs>
        <linearGradient id={areaId} x1="0" x2="0" y1="0" y2="1">
          <stop offset="0%" stopColor={accent} stopOpacity="0.22"/>
          <stop offset="100%" stopColor={accent} stopOpacity="0.02"/>
        </linearGradient>
        <clipPath id={areaId + '-above'}>
          <rect x={pad.l} y={pad.t} width={plotW} height={Math.max(0, goalY - pad.t)} />
        </clipPath>
        <clipPath id={areaId + '-below'}>
          <rect x={pad.l} y={goalY} width={plotW} height={Math.max(0, pad.t + plotH - goalY)} />
        </clipPath>
      </defs>

      {/* y grid */}
      {ySteps.map((v) => (
        <g key={v}>
          <line x1={pad.l} x2={pad.l + plotW} y1={yAt(v)} y2={yAt(v)} stroke={t.line} strokeWidth="1" strokeDasharray="2 3" />
          <text x={pad.l - 6} y={yAt(v) + 3} textAnchor="end" fontSize={9} fontFamily={t.mono} fill={t.ink4}>{v}</text>
        </g>
      ))}

      {/* schedule-change markers */}
      {scheduleChanges.map((idx, i) => (
        <g key={i}>
          <line x1={xAt(idx)} x2={xAt(idx)} y1={pad.t} y2={pad.t + plotH} stroke={accent} strokeWidth="1" strokeDasharray="3 3" opacity="0.55" />
          <g transform={`translate(${xAt(idx)}, ${pad.t - 4})`}>
            <circle r="5" fill={t.card} stroke={accent} strokeWidth="1.2"/>
            <text textAnchor="middle" y="3" fontSize="8" fontFamily={t.mono} fill={accent} fontWeight="700">S</text>
          </g>
        </g>
      ))}

      {/* area fill */}
      <path d={areaPath} fill={`url(#${areaId})`} />

      {/* goal line */}
      <line x1={pad.l} x2={pad.l + plotW} y1={goalY} y2={goalY} stroke={t.ok} strokeWidth="1.4" strokeDasharray="5 4" />
      {showGoalLabel && (
        <g transform={`translate(${pad.l + plotW + 2}, ${goalY + 3})`}>
          <text fontSize={10} fontFamily={t.mono} fontWeight="600" fill={t.okDark}>goal</text>
        </g>
      )}

      {/* line */}
      <path d={linePath} fill="none" stroke={accent} strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/>

      {/* points */}
      {values.map((v, i) => {
        const color = v >= goal ? above : below;
        const isLast = i === values.length - 1;
        return (
          <g key={i}>
            {isLast && <circle cx={xAt(i)} cy={yAt(v)} r="7" fill={color} opacity="0.15"/>}
            <circle cx={xAt(i)} cy={yAt(v)} r={isLast ? 3.2 : 2.4} fill={color} stroke={t.card} strokeWidth="1.2"/>
          </g>
        );
      })}

      {/* x axis labels */}
      {showDays && values.length > 0 && (() => {
        const n = values.length;
        // Show every Nth label to avoid crowding
        const step = n <= 7 ? 1 : n <= 14 ? 2 : 3;
        const labels = [];
        for (let i = 0; i < n; i += step) labels.push(i);
        if (labels[labels.length - 1] !== n - 1) labels.push(n - 1);
        return labels.map((i) => (
          <text key={i} x={xAt(i)} y={pad.t + plotH + 14} textAnchor="middle" fontSize={9} fontFamily={t.mono} fill={t.ink4}>
            {i === n - 1 ? 'today' : `d${i + 1}`}
          </text>
        ));
      })()}
    </svg>
  );
}

Object.assign(window, { ProgressChart });
