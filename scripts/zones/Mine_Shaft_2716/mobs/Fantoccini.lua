-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Fantoccini
-- ENM: Pulling the Strings
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:timer(3000, function(mobArg)
        local battlefieldPlayers = mobArg:getBattlefield():getPlayers()
        local job = mob:getBattlefield():getPlayers()[1]:getMainJob()
        mob:setLocalVar("job", job)

        mobArg:changeJob(job)
        mobArg:setModelId(ID.jobTable[job].modelID)
        mobArg:setSpellList(ID.jobTable[job].spellListID)
        mobArg:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[job].skillList)

        if ID.jobTable[job].petID ~= 0 then
            mobArg:setLocalVar("petID", ID.jobTable[job].petID + mob:getID())
        end
    end)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("petID") > 0 then
        if not GetMobByID(mob:getLocalVar("petID")):isSpawned() and mob:getLocalVar("summoning") == 0 then
            mob:setLocalVar("petSpawned", 0)
        end

        if mob:getLocalVar("petSpawned") == 0 then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:setLocalVar("summoning", 1)
            mob:setLocalVar("petSpawned", 1)
            mob:entityAnimationPacket("casm")
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:timer(3000, function(mobArg)
                if mobArg:isAlive() then
                    local pet = GetMobByID(mobArg:getLocalVar("petID"))
                    local pos = mobArg:getPos()
                    pet:setSpawn(pos.x + math.random(2,3), pos.y, pos.z + math.random(2,3), pos.rot)
                    pet:spawn()
                    mobArg:entityAnimationPacket("shsm")
                    mobArg:SetAutoAttackEnabled(true)
                    mobArg:SetMagicCastingEnabled(true)
                    mobArg:SetMobAbilityEnabled(true)
                    mob:setLocalVar("summoning", 0)
                    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
                end
            end)
        end
    end
end

entity.onMobDeath = function(mob)
    DespawnMob(mob:getID() - 2)
    DespawnMob(mob:getLocalVar("petID"))
end

return entity
