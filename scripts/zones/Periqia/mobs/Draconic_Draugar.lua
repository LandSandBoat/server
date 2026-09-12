-----------------------------------
-- Area: Periqia
--  Mob: Draconic Draugar
-- Involved in Assault: Requiem
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.HPP, -10)
    mob:setMod(xi.mod.ATTP, 15)
    mob:setMod(xi.mod.STORETP, 5)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, xi.mobSkill.CALL_WYVERN_1)
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 1200)
    mob:setPet(GetMobByID(mob:getID() + 1, mob:getInstance()))
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if not instance then
            return
        end

        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
