-----------------------------------
-- Area : Throne Room
-- Mob  : Count Andromalius
-- BCNM : Kindred Spirits
-- Job  : Dark Knight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 6)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.THUNDER,   target, false, xi.action.type.DAMAGE_TARGET,     nil,            0, 100 },
        [2] = { xi.magic.spell.BLIZZARD,  target, false, xi.action.type.DAMAGE_TARGET,     nil,            0, 100 },
        [3] = { xi.magic.spell.DRAIN,     target, false, xi.action.type.DRAIN_HP,          nil,            0, 100 },
        [4] = { xi.magic.spell.ASPIR,     target, false, xi.action.type.DRAIN_MP,          nil,            0, 100 },
        [5] = { xi.magic.spell.STUN,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN, 0, 100 },
        [6] = { xi.magic.spell.ABSORB_TP, target, false, xi.action.type.NONE,              nil,            0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
