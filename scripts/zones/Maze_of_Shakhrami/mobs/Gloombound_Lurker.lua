-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Gloombound Lurker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.CURSE_I,
        power    = 50,
        duration = 300,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 295)
end

return entity
