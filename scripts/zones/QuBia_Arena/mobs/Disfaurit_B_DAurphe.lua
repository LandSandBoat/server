-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Disfaurit B D'Aurphe
-- BCNM: Brothers D'Aurphe
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 50,
        effectId = xi.effect.EVASION_DOWN,
        power    = 25,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

return entity
