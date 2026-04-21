// BehaviorBridge — Mobile screens (iOS frame, 390×844)
// Uses tokens + Icon + Pill + ProgressChart from globals.

const MOBILE_W = 390;
const MOBILE_H = 844;

function MBar({ t, title, back = false, trailing }) {
  return (
    <div style={{
      padding: '14px 18px 10px', display: 'flex', alignItems: 'center',
      gap: 10, background: t.bg, borderBottom: `1px solid ${t.line}`,
      minHeight: 48, boxSizing: 'border-box',
    }}>
      {back ? (
        <button style={{ border: 'none', background: 'transparent', padding: 0, cursor: 'pointer', color: t.accent.stroke, display: 'flex', alignItems: 'center', gap: 2, fontSize: 15, fontWeight: 500, fontFamily: t.font }}>
          <Icon name="chev-l" size={20} color={t.accent.stroke}/> Back
        </button>
      ) : <div style={{ width: 4 }} />}
      <div style={{ flex: 1, textAlign: 'center', fontSize: 15, fontWeight: 600, color: t.ink, fontFamily: t.font }}>{title}</div>
      <div style={{ minWidth: 44, display: 'flex', justifyContent: 'flex-end', color: t.accent.stroke }}>
        {trailing}
      </div>
    </div>
  );
}

function MStatusBar({ t, time = '9:41' }) {
  return (
    <div style={{
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      padding: '14px 28px 4px', fontFamily: t.font, color: t.ink, fontWeight: 600, fontSize: 15,
      background: t.bg,
    }}>
      <span>{time}</span>
      <div style={{ display: 'flex', gap: 6, alignItems: 'center' }}>
        <svg width="17" height="11" viewBox="0 0 17 11"><rect x="0" y="7" width="3" height="4" rx=".5" fill={t.ink}/><rect x="4.5" y="5" width="3" height="6" rx=".5" fill={t.ink}/><rect x="9" y="2.5" width="3" height="8.5" rx=".5" fill={t.ink}/><rect x="13.5" y="0" width="3" height="11" rx=".5" fill={t.ink}/></svg>
        <svg width="25" height="11" viewBox="0 0 25 11"><rect x="0.5" y="0.5" width="21" height="10" rx="2.5" stroke={t.ink} fill="none" opacity=".4"/><rect x="2" y="2" width="18" height="7" rx="1.3" fill={t.ink}/><rect x="22.5" y="3.5" width="1.5" height="4" rx=".6" fill={t.ink} opacity=".4"/></svg>
      </div>
    </div>
  );
}

// Simple iOS-style home indicator
function MHomeBar({ t }) {
  return (
    <div style={{ height: 28, display: 'flex', justifyContent: 'center', alignItems: 'flex-end', paddingBottom: 8, background: t.bg }}>
      <div style={{ width: 130, height: 5, borderRadius: 3, background: t.ink, opacity: 0.85 }}/>
    </div>
  );
}

function MScreen({ t, children, padTop = true, padBottom = true }) {
  return (
    <div style={{
      width: MOBILE_W, height: MOBILE_H, background: t.bg, fontFamily: t.font,
      color: t.ink, display: 'flex', flexDirection: 'column', position: 'relative',
      overflow: 'hidden', WebkitFontSmoothing: 'antialiased',
    }}>
      {padTop && <MStatusBar t={t}/>}
      {children}
      {padBottom && <MHomeBar t={t}/>}
    </div>
  );
}

function MCard({ t, children, style = {}, pad = 16 }) {
  return (
    <div style={{
      background: t.card, borderRadius: t.r.lg, padding: pad,
      border: `1px solid ${t.line}`, boxShadow: t.sh1, ...style,
    }}>{children}</div>
  );
}

function MButton({ t, children, variant = 'primary', full = false, icon }) {
  const st = {
    primary: { bg: t.accent.stroke, fg: '#fff', border: t.accent.stroke },
    secondary: { bg: t.card, fg: t.ink, border: t.line },
    ghost: { bg: 'transparent', fg: t.accent.stroke, border: 'transparent' },
  }[variant];
  return (
    <button style={{
      background: st.bg, color: st.fg, border: `1px solid ${st.border}`,
      padding: '13px 18px', borderRadius: t.r.md, fontSize: 15, fontWeight: 600,
      fontFamily: t.font, cursor: 'pointer', width: full ? '100%' : undefined,
      display: 'inline-flex', alignItems: 'center', justifyContent: 'center', gap: 8,
    }}>{icon}{children}</button>
  );
}

function MSectionHeader({ t, children, right }) {
  return (
    <div style={{ display: 'flex', alignItems: 'baseline', justifyContent: 'space-between', padding: '0 20px', marginBottom: 8 }}>
      <div style={{ fontSize: 12, fontWeight: 600, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.6 }}>{children}</div>
      {right}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// 1. Home screen — list of subjects
// ─────────────────────────────────────────────────────────────
function ScreenHome({ t }) {
  return (
    <MScreen t={t}>
      <div style={{ padding: '16px 20px 14px', background: t.bg }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 4 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <div style={{ width: 26, height: 26, borderRadius: 7, background: t.accent.stroke, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#fff' }}>
              <Icon name="spark" size={15}/>
            </div>
            <div style={{ fontSize: 16, fontWeight: 700, letterSpacing: -0.2 }}>BehaviorBridge</div>
          </div>
          <button style={{ border: 'none', background: t.accent.tint, color: t.accent.pillFg, width: 34, height: 34, borderRadius: 999, display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer' }}>
            <Icon name="plus" size={18}/>
          </button>
        </div>
        <div style={{ fontSize: 28, fontWeight: 700, letterSpacing: -0.5, marginTop: 14 }}>Who are we<br/>supporting today?</div>
        <div style={{ fontSize: 14, color: t.ink3, marginTop: 6 }}>Pick a child to log or review.</div>
      </div>

      <div style={{ flex: 1, overflow: 'auto', padding: '8px 0 20px' }}>
        <MSectionHeader t={t}>Children</MSectionHeader>
        <div style={{ padding: '0 16px', display: 'flex', flexDirection: 'column', gap: 10 }}>
          {SUBJECTS.map((s, i) => (
            <div key={s.id} style={{
              background: t.card, borderRadius: t.r.lg, padding: '14px 14px',
              border: `1px solid ${t.line}`, display: 'flex', alignItems: 'center', gap: 12,
              boxShadow: t.sh1,
            }}>
              <div style={{
                width: 42, height: 42, borderRadius: 12,
                background: i === 0 ? t.accent.tint : i === 1 ? t.okTint : t.warnTint,
                color: i === 0 ? t.accent.pillFg : i === 1 ? t.okDark : t.warnDark,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontWeight: 700, fontSize: 15, letterSpacing: -0.2,
              }}>{s.emoji}</div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ fontSize: 15, fontWeight: 600, color: t.ink }}>{s.name}</div>
                <div style={{ fontSize: 12, color: t.ink3, marginTop: 2 }}>
                  {s.ageYears} yrs · {s.relationship} · {s.targetCount} target{s.targetCount !== 1 ? 's' : ''}
                </div>
              </div>
              <Icon name="chev-r" size={18} color={t.ink4}/>
            </div>
          ))}
        </div>

        <MSectionHeader t={t}>
          <span style={{ marginTop: 20, display: 'block' }}>Today at a glance</span>
        </MSectionHeader>
        <div style={{ padding: '0 16px' }}>
          <MCard t={t} pad={14}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
              <div style={{ width: 34, height: 34, borderRadius: 10, background: t.okTint, color: t.okDark, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon name="check" size={18}/>
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 13, fontWeight: 600 }}>2 logs still to record</div>
                <div style={{ fontSize: 12, color: t.ink3 }}>Maya · Owen</div>
              </div>
              <Pill t={t} tone="accent" size="sm">Log now</Pill>
            </div>
          </MCard>
        </div>
      </div>
    </MScreen>
  );
}

// ─────────────────────────────────────────────────────────────
// 2. Subject detail — list of targets
// ─────────────────────────────────────────────────────────────
function ScreenSubject({ t, stateKey }) {
  const a = ANALYSIS[stateKey];
  return (
    <MScreen t={t}>
      <MBar t={t} back title="Maya" trailing={<Icon name="more" size={20}/>}/>
      <div style={{ flex: 1, overflow: 'auto' }}>
        <div style={{ padding: '16px 20px 8px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <div style={{ width: 56, height: 56, borderRadius: 16, background: t.accent.tint, color: t.accent.pillFg, display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700, fontSize: 22 }}>M</div>
            <div>
              <div style={{ fontSize: 20, fontWeight: 700 }}>Maya</div>
              <div style={{ fontSize: 13, color: t.ink3 }}>6 years · at home · since Mar 8</div>
            </div>
          </div>
        </div>

        <MSectionHeader t={t} right={
          <button style={{ border: 'none', background: 'transparent', color: t.accent.stroke, fontSize: 13, fontWeight: 600, cursor: 'pointer', display: 'inline-flex', alignItems: 'center', gap: 3 }}>
            <Icon name="plus" size={14}/> New target
          </button>
        }><span style={{ marginTop: 8, display: 'block' }}>Behavior targets</span></MSectionHeader>

        <div style={{ padding: '0 16px', display: 'flex', flexDirection: 'column', gap: 10 }}>
          {/* Active target — tied to state */}
          <div style={{
            background: t.card, borderRadius: t.r.lg, padding: 14,
            border: `1px solid ${t.line}`, boxShadow: t.sh1,
          }}>
            <div style={{ display: 'flex', alignItems: 'flex-start', gap: 10, marginBottom: 10 }}>
              <div style={{ width: 32, height: 32, borderRadius: 9, background: t.accent.tint, color: t.accent.stroke, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                <Icon name="target" size={18}/>
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ fontSize: 15, fontWeight: 600, lineHeight: 1.3 }}>{TARGET.label}</div>
                <div style={{ fontSize: 12, color: t.ink3, marginTop: 2 }}>Goal: {TARGET.goalFrequency}×/day · Increase</div>
              </div>
              <Pill t={t} tone={a.pillTone} size="sm">{a.pillLabel}</Pill>
            </div>
            <ProgressChart values={LOG_SERIES[stateKey]} goal={TARGET.goalFrequency} width={322} height={90} t={t} compact showDays={false} showGoalLabel={false} scheduleChanges={stateKey === 'scheduleUpgrade' ? [6] : []}/>
            <div style={{ display: 'flex', gap: 8, marginTop: 10 }}>
              <MButton t={t} variant="primary" full icon={<Icon name="check" size={16}/>}>Log today</MButton>
              <MButton t={t} variant="secondary" icon={<Icon name="trend" size={16}/>}>Progress</MButton>
            </div>
          </div>

          {/* Second target — kept brief */}
          <div style={{
            background: t.card, borderRadius: t.r.lg, padding: 14,
            border: `1px solid ${t.line}`, boxShadow: t.sh1, display: 'flex', gap: 10, alignItems: 'center',
          }}>
            <div style={{ width: 32, height: 32, borderRadius: 9, background: t.line2, color: t.ink3, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name="target" size={18}/>
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 14, fontWeight: 600 }}>Putting on shoes independently</div>
              <div style={{ fontSize: 12, color: t.ink3 }}>Baseline · 1 of 3 days logged</div>
            </div>
            <Icon name="chev-r" size={18} color={t.ink4}/>
          </div>
        </div>

        <MSectionHeader t={t}><span style={{ marginTop: 20, display: 'block' }}>Completed</span></MSectionHeader>
        <div style={{ padding: '0 16px 20px' }}>
          <div style={{
            background: t.card, borderRadius: t.r.lg, padding: 14,
            border: `1px solid ${t.line}`, display: 'flex', gap: 10, alignItems: 'center',
          }}>
            <div style={{ width: 32, height: 32, borderRadius: 9, background: t.okTint, color: t.okDark, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name="star" size={16}/>
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 14, fontWeight: 600 }}>Saying "please" when asking</div>
              <div style={{ fontSize: 12, color: t.ink3 }}>Goal reached · 24 days</div>
            </div>
            <Icon name="chev-r" size={18} color={t.ink4}/>
          </div>
        </div>
      </div>
    </MScreen>
  );
}

// ─────────────────────────────────────────────────────────────
// 3. Create target — form
// ─────────────────────────────────────────────────────────────
function ScreenCreateTarget({ t }) {
  const FieldLabel = ({ children, hint }) => (
    <div style={{ marginBottom: 6, display: 'flex', alignItems: 'baseline', justifyContent: 'space-between' }}>
      <div style={{ fontSize: 12, fontWeight: 600, color: t.ink2, textTransform: 'uppercase', letterSpacing: 0.5 }}>{children}</div>
      {hint && <div style={{ fontSize: 11, color: t.ink4 }}>{hint}</div>}
    </div>
  );
  const Input = ({ value, placeholder }) => (
    <div style={{
      background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.md,
      padding: '12px 14px', fontSize: 15, color: value ? t.ink : t.ink4,
    }}>{value || placeholder}</div>
  );

  return (
    <MScreen t={t}>
      <MBar t={t} back title="New target" trailing={<span style={{ fontSize: 15, color: t.accent.stroke, fontWeight: 600 }}>Save</span>}/>
      <div style={{ flex: 1, overflow: 'auto', padding: '16px 20px 20px' }}>
        <div style={{ fontSize: 13, color: t.ink3, marginBottom: 18, lineHeight: 1.5 }}>
          Start with one clear, observable behavior. Keep it specific — "tidies toys" is easier to track than "is neater".
        </div>

        <FieldLabel>Behavior</FieldLabel>
        <Input value="Tidying up toys after play"/>

        <div style={{ height: 14 }}/>
        <FieldLabel hint="optional">What does it look like?</FieldLabel>
        <div style={{
          background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.md,
          padding: '12px 14px', fontSize: 14, color: t.ink2, lineHeight: 1.4, minHeight: 66,
        }}>Puts all toys into the toy bin within 5 minutes of being asked.</div>

        <div style={{ height: 18 }}/>
        <FieldLabel>I want to see this</FieldLabel>
        <div style={{ display: 'flex', gap: 8 }}>
          {[
            { k: 'more', label: 'More often', icon: 'trend' },
            { k: 'less', label: 'Less often', icon: 'warn' },
          ].map((o, i) => (
            <div key={o.k} style={{
              flex: 1, padding: '12px 12px', borderRadius: t.r.md,
              background: i === 0 ? t.accent.tint : t.card,
              border: `1px solid ${i === 0 ? t.accent.stroke : t.line}`,
              color: i === 0 ? t.accent.pillFg : t.ink2,
              display: 'flex', flexDirection: 'column', gap: 6,
            }}>
              <Icon name={o.icon} size={18} color={i === 0 ? t.accent.stroke : t.ink3}/>
              <div style={{ fontSize: 14, fontWeight: 600 }}>{o.label}</div>
            </div>
          ))}
        </div>

        <div style={{ height: 18 }}/>
        <FieldLabel hint="per day">Baseline and goal</FieldLabel>
        <MCard t={t} pad={14}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 14 }}>
            <div>
              <div style={{ fontSize: 12, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.4 }}>Where we are</div>
              <div style={{ fontSize: 24, fontWeight: 700, color: t.ink, fontFamily: t.mono }}>1×<span style={{ fontSize: 13, color: t.ink3, fontFamily: t.font, fontWeight: 500, marginLeft: 4 }}>/day</span></div>
            </div>
            <Icon name="arrow-r" size={22} color={t.ink4}/>
            <div style={{ textAlign: 'right' }}>
              <div style={{ fontSize: 12, color: t.ok, textTransform: 'uppercase', letterSpacing: 0.4, fontWeight: 600 }}>Goal</div>
              <div style={{ fontSize: 24, fontWeight: 700, color: t.okDark, fontFamily: t.mono }}>4×<span style={{ fontSize: 13, color: t.ink3, fontFamily: t.font, fontWeight: 500, marginLeft: 4 }}>/day</span></div>
            </div>
          </div>
          {/* Slider track */}
          <div style={{ height: 6, background: t.line, borderRadius: 3, position: 'relative' }}>
            <div style={{ position: 'absolute', left: '14%', right: '42%', top: 0, bottom: 0, background: t.accent.stroke, borderRadius: 3 }}/>
            <div style={{ position: 'absolute', left: '14%', top: -6, width: 18, height: 18, background: t.card, border: `2px solid ${t.accent.stroke}`, borderRadius: 99, transform: 'translateX(-9px)' }}/>
            <div style={{ position: 'absolute', left: '58%', top: -6, width: 18, height: 18, background: t.ok, border: `2px solid ${t.okDark}`, borderRadius: 99, transform: 'translateX(-9px)' }}/>
          </div>
        </MCard>

        <div style={{ height: 24 }}/>
        <MButton t={t} full icon={<Icon name="arrow-r" size={18} color="#fff"/>}>Next: pick rewards</MButton>
      </div>
    </MScreen>
  );
}

// ─────────────────────────────────────────────────────────────
// 4. Schedule setup — pick reinforcement schedule
// ─────────────────────────────────────────────────────────────
function ScreenSchedule({ t }) {
  const opts = [
    { k: 'crf', label: 'Every time',       uiName: 'Reward every occurrence', desc: 'Best for brand-new behaviors.', icon: 'check', recommended: true },
    { k: 'fr',  label: 'Every X times',    uiName: 'Reward every 2nd',        desc: 'When the habit is getting established.', icon: 'grid', recommended: false },
    { k: 'vr',  label: 'Surprise reward',  uiName: 'Reward on average every 3rd', desc: 'Strongest long-term — hardest to forget.', icon: 'spark', recommended: false },
    { k: 'fi',  label: 'After X minutes',  uiName: 'Reward after 10 min',     desc: 'For time-based behaviors like staying seated.', icon: 'calendar', recommended: false },
  ];

  return (
    <MScreen t={t}>
      <MBar t={t} back title="Reward schedule" trailing={<Icon name="info" size={20} color={t.accent.stroke}/>}/>
      <div style={{ flex: 1, overflow: 'auto', padding: '12px 20px 20px' }}>
        <div style={{
          background: t.accent.tint, color: t.accent.pillFg, padding: 14,
          borderRadius: t.r.lg, display: 'flex', gap: 10, alignItems: 'flex-start', marginBottom: 18,
        }}>
          <Icon name="spark" size={20} color={t.accent.stroke}/>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 13, fontWeight: 700, marginBottom: 2 }}>We suggest "Every time" to start</div>
            <div style={{ fontSize: 12, lineHeight: 1.45 }}>New habits form fastest when every attempt is rewarded. We'll suggest moving to a less frequent schedule once Maya is consistent.</div>
          </div>
        </div>

        <div style={{ fontSize: 12, fontWeight: 600, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5, marginBottom: 8 }}>How often to reward</div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {opts.map((o) => (
            <div key={o.k} style={{
              background: t.card, borderRadius: t.r.lg, padding: 14,
              border: `1px solid ${o.recommended ? t.accent.stroke : t.line}`,
              boxShadow: o.recommended ? `0 0 0 3px ${t.accent.tint}` : t.sh1,
              display: 'flex', gap: 12, alignItems: 'flex-start',
            }}>
              <div style={{
                width: 32, height: 32, borderRadius: 9,
                background: o.recommended ? t.accent.stroke : t.line2,
                color: o.recommended ? '#fff' : t.ink3,
                display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
              }}>
                <Icon name={o.icon} size={16} color={o.recommended ? '#fff' : t.ink3}/>
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                  <div style={{ fontSize: 14, fontWeight: 700 }}>{o.label}</div>
                  {o.recommended && <Pill t={t} tone="accent" size="sm">Suggested</Pill>}
                </div>
                <div style={{ fontSize: 13, color: t.ink2, marginTop: 2 }}>{o.uiName}</div>
                <div style={{ fontSize: 12, color: t.ink3, marginTop: 4, lineHeight: 1.4 }}>{o.desc}</div>
              </div>
            </div>
          ))}
        </div>

        <div style={{ height: 18 }}/>
        <div style={{ fontSize: 12, fontWeight: 600, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5, marginBottom: 8 }}>What's the reward?</div>
        <MCard t={t} pad={14}>
          <div style={{ fontSize: 14, fontWeight: 600, marginBottom: 4 }}>Sticker on chart</div>
          <div style={{ fontSize: 12, color: t.ink3 }}>5 min screen time at 4 stickers</div>
        </MCard>

        <div style={{ height: 20 }}/>
        <MButton t={t} full>Start tracking</MButton>
      </div>
    </MScreen>
  );
}

// ─────────────────────────────────────────────────────────────
// 5. Daily log — quick entry
// ─────────────────────────────────────────────────────────────
function ScreenLog({ t, stateKey }) {
  const values = LOG_SERIES[stateKey];
  const todayCount = values[values.length - 1];
  const goal = TARGET.goalFrequency;
  const pct = Math.min(100, (todayCount / goal) * 100);
  const atGoal = todayCount >= goal;
  const reinfGiven = REINF_SERIES[stateKey][REINF_SERIES[stateKey].length - 1];

  return (
    <MScreen t={t}>
      <MBar t={t} back title="Log for today" trailing={<Icon name="calendar" size={20}/>}/>
      <div style={{ flex: 1, overflow: 'auto', padding: '16px 20px 20px' }}>
        <div style={{ fontSize: 13, color: t.ink3, marginBottom: 4 }}>Tuesday, Apr 21</div>
        <div style={{ fontSize: 22, fontWeight: 700, marginBottom: 14, letterSpacing: -0.4 }}>{TARGET.label}</div>

        {/* Counter */}
        <div style={{
          background: atGoal ? t.okTint : t.card, borderRadius: t.r.xl,
          padding: '20px 18px', border: `1px solid ${atGoal ? t.ok : t.line}`,
          display: 'flex', alignItems: 'center', gap: 14,
        }}>
          <button style={{
            width: 48, height: 48, borderRadius: 999, border: `1px solid ${t.line}`,
            background: t.card, color: t.ink2, cursor: 'pointer', display: 'flex',
            alignItems: 'center', justifyContent: 'center',
          }}>
            <svg width="18" height="2"><rect width="18" height="2" rx="1" fill={t.ink2}/></svg>
          </button>
          <div style={{ flex: 1, textAlign: 'center' }}>
            <div style={{ fontSize: 11, fontWeight: 600, color: atGoal ? t.okDark : t.ink3, textTransform: 'uppercase', letterSpacing: 0.6 }}>Times today</div>
            <div style={{ fontSize: 56, fontWeight: 800, lineHeight: 1, color: atGoal ? t.okDark : t.ink, fontFamily: t.mono, letterSpacing: -1.5 }}>{todayCount}</div>
            <div style={{ fontSize: 12, color: t.ink3, marginTop: 4 }}>of {goal} goal</div>
          </div>
          <button style={{
            width: 48, height: 48, borderRadius: 999, border: 'none',
            background: t.accent.stroke, color: '#fff', cursor: 'pointer', display: 'flex',
            alignItems: 'center', justifyContent: 'center',
          }}>
            <Icon name="plus" size={22} color="#fff"/>
          </button>
        </div>

        {/* Progress bar */}
        <div style={{ height: 6, background: t.line, borderRadius: 3, marginTop: 14, overflow: 'hidden' }}>
          <div style={{ height: '100%', width: `${pct}%`, background: atGoal ? t.ok : t.accent.stroke, transition: 'width .2s' }}/>
        </div>
        <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 6, fontSize: 11, color: t.ink3, fontFamily: t.mono }}>
          <span>0</span><span>{goal}</span>
        </div>

        {/* Reinforcement toggle */}
        <div style={{ height: 18 }}/>
        <MCard t={t} pad={14}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <div style={{ width: 34, height: 34, borderRadius: 9, background: reinfGiven ? t.okTint : t.riskTint, color: reinfGiven ? t.okDark : t.risk, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name={reinfGiven ? 'check' : 'warn'} size={18}/>
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 14, fontWeight: 600 }}>Reward given</div>
              <div style={{ fontSize: 12, color: t.ink3 }}>Sticker on chart</div>
            </div>
            <div style={{
              width: 46, height: 28, borderRadius: 999, background: reinfGiven ? t.ok : t.line,
              position: 'relative', transition: 'background .2s',
            }}>
              <div style={{
                position: 'absolute', top: 2, left: reinfGiven ? 20 : 2, width: 24, height: 24,
                background: '#fff', borderRadius: 999, boxShadow: '0 1px 3px rgba(0,0,0,.2)', transition: 'left .2s',
              }}/>
            </div>
          </div>
        </MCard>

        <div style={{ height: 12 }}/>
        <div style={{ fontSize: 12, fontWeight: 600, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5, marginBottom: 6 }}>Notes (optional)</div>
        <div style={{
          background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.md,
          padding: '12px 14px', fontSize: 13, color: t.ink4, minHeight: 54,
        }}>Had to ask twice, but she did it without a fuss the second time.</div>

        <div style={{ height: 20 }}/>
        <MButton t={t} full icon={<Icon name="check" size={18} color="#fff"/>}>Save log</MButton>
      </div>
    </MScreen>
  );
}

// ─────────────────────────────────────────────────────────────
// 6. Progress — full chart
// ─────────────────────────────────────────────────────────────
function ScreenProgress({ t, stateKey }) {
  const values = LOG_SERIES[stateKey];
  const a = ANALYSIS[stateKey];
  const avg = (values.reduce((x, y) => x + y, 0) / values.length).toFixed(1);
  const daysAtGoal = values.filter((v) => v >= TARGET.goalFrequency).length;

  return (
    <MScreen t={t}>
      <MBar t={t} back title="Progress" trailing={<Icon name="more" size={20}/>}/>
      <div style={{ flex: 1, overflow: 'auto', padding: '12px 16px 20px' }}>
        <div style={{ padding: '0 4px 10px' }}>
          <div style={{ fontSize: 12, color: t.ink3, fontFamily: t.mono, letterSpacing: 0.4 }}>{TARGET.label.toUpperCase()}</div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 4 }}>
            <div style={{ fontSize: 20, fontWeight: 700 }}>Last {values.length} days</div>
            <Pill t={t} tone={a.pillTone} size="sm">{a.pillLabel}</Pill>
          </div>
        </div>

        <MCard t={t} pad={12}>
          <ProgressChart
            values={values}
            goal={TARGET.goalFrequency}
            width={330}
            height={190}
            t={t}
            scheduleChanges={stateKey === 'scheduleUpgrade' || stateKey === 'goalReached' ? [6] : []}
          />
        </MCard>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 8, marginTop: 12 }}>
          {[
            { label: 'Avg/day', val: avg },
            { label: 'At goal', val: `${daysAtGoal}d` },
            { label: 'Streak',  val: stateKey === 'goalReached' ? '10d' : stateKey === 'scheduleUpgrade' ? '7d' : '3d' },
          ].map((s) => (
            <div key={s.label} style={{ background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.md, padding: 10 }}>
              <div style={{ fontSize: 10, fontWeight: 600, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5 }}>{s.label}</div>
              <div style={{ fontSize: 20, fontWeight: 700, fontFamily: t.mono, marginTop: 2 }}>{s.val}</div>
            </div>
          ))}
        </div>

        {/* Suggestion preview */}
        <div style={{ height: 14 }}/>
        <div style={{
          background: a.pillTone === 'ok' ? t.okTint : a.pillTone === 'warn' ? t.warnTint : a.pillTone === 'risk' ? t.riskTint : t.accent.tint,
          borderRadius: t.r.lg, padding: 14,
          border: `1px solid ${a.pillTone === 'ok' ? t.ok : a.pillTone === 'warn' ? t.warn : a.pillTone === 'risk' ? t.risk : t.accent.stroke}33`,
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 6 }}>
            <Icon name={a.pillTone === 'risk' ? 'warn' : a.pillTone === 'warn' ? 'info' : 'spark'} size={18} color={a.pillTone === 'ok' ? t.okDark : a.pillTone === 'warn' ? t.warnDark : a.pillTone === 'risk' ? t.risk : t.accent.stroke}/>
            <div style={{ fontSize: 14, fontWeight: 700, color: a.pillTone === 'ok' ? t.okDark : a.pillTone === 'warn' ? t.warnDark : a.pillTone === 'risk' ? t.risk : t.accent.pillFg }}>{a.headline}</div>
          </div>
          <div style={{ fontSize: 13, color: t.ink2, lineHeight: 1.5 }}>{a.explanation}</div>
          {a.actionableAdvice && (
            <div style={{ marginTop: 10, display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
              <div style={{ fontSize: 13, fontWeight: 600, color: t.ink }}>{a.actionableAdvice}</div>
              <button style={{
                border: 'none', background: t.ink, color: '#fff', fontSize: 12, fontWeight: 600,
                padding: '6px 12px', borderRadius: 999, cursor: 'pointer',
              }}>See why</button>
            </div>
          )}
        </div>
      </div>
    </MScreen>
  );
}

// ─────────────────────────────────────────────────────────────
// 7. Suggestion — full explanation page
// ─────────────────────────────────────────────────────────────
function ScreenSuggestion({ t, stateKey }) {
  const a = ANALYSIS[stateKey];
  const tone = a.pillTone;
  const hero = tone === 'ok' ? t.ok : tone === 'warn' ? t.warn : tone === 'risk' ? t.risk : t.accent.stroke;
  const heroTint = tone === 'ok' ? t.okTint : tone === 'warn' ? t.warnTint : tone === 'risk' ? t.riskTint : t.accent.tint;

  return (
    <MScreen t={t}>
      <MBar t={t} back title="What to do next" trailing={<span style={{ fontSize: 14, color: t.accent.stroke, fontWeight: 600 }}>Why?</span>}/>
      <div style={{ flex: 1, overflow: 'auto' }}>
        <div style={{ background: heroTint, padding: '22px 24px 22px' }}>
          <div style={{ width: 44, height: 44, borderRadius: 12, background: hero, display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 12 }}>
            <Icon name={tone === 'ok' ? (stateKey === 'goalReached' ? 'cel' : 'spark') : tone === 'warn' ? 'info' : tone === 'risk' ? 'warn' : 'spark'} size={22} color="#fff"/>
          </div>
          <div style={{ fontSize: 22, fontWeight: 700, lineHeight: 1.25, letterSpacing: -0.3 }}>{a.headline}</div>
          <div style={{ fontSize: 14, color: t.ink2, marginTop: 8, lineHeight: 1.55 }}>{a.explanation}</div>
        </div>

        <div style={{ padding: '18px 20px 20px' }}>
          {a.actionableAdvice && (
            <>
              <div style={{ fontSize: 12, fontWeight: 600, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5, marginBottom: 8 }}>Try this</div>
              <MCard t={t} pad={14}>
                <div style={{ display: 'flex', alignItems: 'flex-start', gap: 10 }}>
                  <div style={{ width: 28, height: 28, borderRadius: 7, background: t.accent.tint, color: t.accent.stroke, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                    <Icon name="flag" size={16}/>
                  </div>
                  <div style={{ fontSize: 14, color: t.ink, lineHeight: 1.45, fontWeight: 500 }}>{a.actionableAdvice}</div>
                </div>
              </MCard>
            </>
          )}

          {/* Why / science note */}
          <div style={{ height: 16 }}/>
          <div style={{ fontSize: 12, fontWeight: 600, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5, marginBottom: 8 }}>Why this works</div>
          <MCard t={t} pad={14}>
            <div style={{ fontSize: 13, color: t.ink2, lineHeight: 1.55 }}>
              {stateKey === 'scheduleUpgrade' && 'Behaviors rewarded every single time learn fast — but they also fade fast when rewards stop. Rewarding every second time builds resilience: the brain learns "it might happen", which keeps the habit going even on days you forget.'}
              {stateKey === 'onTrack'         && 'During the early days of a new habit, consistency beats variety. Keep the rewards predictable until Maya has hit the goal 5–7 days in a row.'}
              {stateKey === 'baseline'        && 'A baseline tells us what "normal" looks like for Maya right now. Without it, we can\'t tell if progress is real — or if the reward is doing anything.'}
              {stateKey === 'plateau'         && 'Plateaus usually mean the reward has lost its sparkle, or the ask has become too easy to matter. A small change — a new reward, a smaller ask — often kicks things back into gear.'}
              {stateKey === 'extinctionRisk'  && 'Behaviors depend on feedback. Three days without a reward tells Maya\'s brain "this isn\'t important" — and the habit will start to fade. Reinstate the sticker today to course-correct.'}
              {stateKey === 'goalReached'     && 'At 7+ days of consistent success, the behavior is officially a habit. Switching to surprise rewards (rather than stopping completely) keeps it strong for the long run.'}
            </div>
          </MCard>

          {/* Two actions */}
          <div style={{ height: 18 }}/>
          <MButton t={t} full>
            {stateKey === 'scheduleUpgrade' ? 'Switch to "Every 2nd time"' :
             stateKey === 'goalReached' ? 'Move to surprise rewards' :
             stateKey === 'plateau' ? 'Try a new reward' :
             stateKey === 'extinctionRisk' ? 'Set a reminder' :
             'Keep going'}
          </MButton>
          <div style={{ height: 8 }}/>
          <MButton t={t} full variant="secondary">Remind me tomorrow</MButton>
        </div>
      </div>
    </MScreen>
  );
}

Object.assign(window, {
  MOBILE_W, MOBILE_H,
  ScreenHome, ScreenSubject, ScreenCreateTarget,
  ScreenSchedule, ScreenLog, ScreenProgress, ScreenSuggestion,
});
