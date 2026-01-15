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
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.STORETP, 30)

    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
end

-- This quest NM has a special JUICED version of Cross Attack that will need to be fixed when mob skills are updated.  It's likely 4X base damage.
entity.onMobMobskillChoose = function(mob, target)
    local skillList =
    {
        xi.mobSkill.CROSS_ATTACK_1,
        xi.mobSkill.MAELSTROM_1
    }

    return skillList[math.random(1, #skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar('anUndyingPledgeCS') == 2 then
        player:setCharVar('anUndyingPledgeNM_killed', 1)
    end
end

return entity
