-----------------------------------
-- Era TP Gain Formula (Module Override)
-- Overwrites: xi.combat.tp.calculateTPReturn(gainee, delay)
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
