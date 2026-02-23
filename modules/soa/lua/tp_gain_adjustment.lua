-----------------------------------
-- Era TP Gain Formula (Module Override)
--
-- Overrides:
--   xi.combat.tp.calculateTPReturn(gainee, delay)
--
-- Purpose:
--   Restores pre-June 2014 TP gain behavior (75-era scaling).
--
-- Historical References:
--
--   JP Wiki (Studio Gobli Testing)
--   https://w.atwiki.jp/studiogobli/pages/21.html
--   - Example: Claymore (Delay 444) = 11.3 TP/hit
--     (113 base × 9 hits ≈ 1017 TP total)
--
--   BGWiki (Store TP Discussion)
--   https://www.bg-wiki.com/ffxi/Talk%3AStore_TP
--   - Community-tested formulas
--   - Article revision dated April 4, 2021
--
--   FFXIclopedia (Tactical Points)
--   https://ffxiclopedia.fandom.com/wiki/Tactical_Points
--   - Documents older TP formulas
--   - Notes June 2014 adjustment
--
--   Square Enix Official Forum Post
--   https://forum.square-enix.com/ffxi/threads/42614#post511262
--   - Confirms TP generation for players was increased (June 2014)
-----------------------------------
require('modules/module_utils')
require('scripts/globals/combat/tp')

local m = Module:new('era_tp_gain')
m:addOverride('xi.combat.tp.calculateTPReturn', function(_, delay)
    local tpReturn = 0
    -- PCs + Pets + Mobs
    if delay < 180 then     -- 0~180
        tpReturn = 50 + (delay - 180) * 15 / 180
    elseif delay < 450 then -- 180~450
        tpReturn = 50 + (delay - 180) * 65 / 270
    elseif delay < 480 then -- 450~480
        tpReturn = 115 + (delay - 450) * 15 / 30
    elseif delay < 530 then -- 480~530
        tpReturn = 130 + (delay - 480) * 15 / 50
    else
        tpReturn = 145 + (delay - 530) * 35 / 470
    end

    return math.floor(tpReturn)
end)

return m
