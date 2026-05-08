-----------------------------------
-- Module: Job Adjustments (Seekers of Adoulin era)
-- Desc: Revert to original TP gain formula shared for mobs and players
-- See: https://wiki.ffo.jp/html/308.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('soa_tp_gain')

-- all entities will use the this formula
-- gainee is unused, in the normal code we need to pull objtype but not here
m:addOverride('xi.combat.tp.calculateTPReturn', function(gainee, delay)
    local tpReturn = 0

    if delay > 530 then
        tpReturn = 145 + (delay - 530) * 35 / 470
    elseif delay > 480 then
        tpReturn = 130 + (delay - 480) * 15 / 30
    elseif delay > 450 then
        tpReturn = 115 + (delay - 450) * 15 / 30
    elseif delay > 180 then
        tpReturn = 50 + (delay - 180) * 65 / 270
    else
        tpReturn = 50 + (delay - 180) * 15 / 180
    end

    return math.floor(tpReturn)
end)

return m
