-----------------------------------
-- Area: Sea Serpent Grotto
-- Mob: Glyryvilu
-- Note: Popped by qm5
-- !pos 135 -9 220
-- Involved in Quest: An Undying Pledge
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setfTPModifierOverride(xi.mobSkill.CROSS_ATTACK_1, 6.0, 6.0, 6.0)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.STORETP, 30)

    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.CROSS_ATTACK_1,
        xi.mobSkill.MAELSTROM_1
    }

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar('anUndyingPledgeCS') == 2 then
        player:setCharVar('anUndyingPledgeNM_killed', 1)
    end
end

return entity
