-----------------------------------
-- Area: Abyssea - Grauberg
--   NM: Fleshflayer Killakriq
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpList =
    {
        xi.mobSkill.FRYPAN_1,
        xi.mobSkill.SMOKEBOMB_1,
        xi.mobSkill.CRISPY_CANDLE_1,
        xi.mobSkill.PARALYSIS_SHOWER_1,
        xi.mobSkill.GOBLIN_RUSH_1,
    }

    return tpList[math.random(1, #tpList)]
end

return entity
