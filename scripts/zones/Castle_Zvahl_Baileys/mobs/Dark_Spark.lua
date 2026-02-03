-----------------------------------
-- Area: Castle Zvahl Baileys
--  Mob: Dark Spark
-- Involved in Quests: Borghertz's Hands (AF Hands, Many job)
-- !pos 63 -24 21 161
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.BERSERK_BOMB,
    }

    if mob:getHPP() < 10 then
        table.insert(skillList, xi.mobSkill.SELF_DESTRUCT_BOMB)
    end

    return skillList[math.random(1, #skillList)]
end

return entity
