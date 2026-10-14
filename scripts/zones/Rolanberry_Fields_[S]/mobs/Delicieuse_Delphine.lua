-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Delicieuse Delphine
-- https://www.bg-wiki.com/ffxi/Delicieuse_Delphine
-- Only uses Impale, and does it in threes
-- TODO allow deaggro based on distance (core CMobEntity::CanDeaggro() forces NM and Battlefield mobs to never stop chasing)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 50)
    mob:addMod(xi.mod.MOVE_SPEED_STACKABLE, 18)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    mob:setLocalVar('impaleCount', 2)

    return 316 -- Impale
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if mob:getLocalVar('impaleCount') > 0 then
        mob:setLocalVar('impaleCount', mob:getLocalVar('impaleCount') - 1)
        mob:useMobAbility(skill:getID())
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 50,
        effectId = xi.effect.PARALYSIS,
        power    = 20,
        duration = 30,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 513)
end

return entity
