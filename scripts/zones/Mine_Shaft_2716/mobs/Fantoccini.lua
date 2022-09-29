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
        mobArg:setLocalVar("petID", ID.jobTable[job].petID + mob:getID())
        mobArg:setSpellList(ID.jobTable[job].spellListID)
        mobArg:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[job].skillList)
    end)
end

entity.onMobFight = function(mob, target)
    -- if not GetMobByID(mob:getLocalVar("petID")):isSpawned() then
        -- print("Pet ded")
        -- mob:setLocalVar("petSpawned", 0)
    -- end

    -- Summon Pet
    if mob:getLocalVar("petSpawned") == 0 and mob:getLocalVar("petID") > 0 then
        print("summoning")
        mob:setLocalVar("petSpawned", 1)
        mob:entityAnimationPacket("casm")
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:timer(3000, function(mobArg)
            if mobArg:isAlive() then
                local pet = GetMobByID(mobArg:getLocalVar("petID"))
                local pos = mobArg:getPos()
                pet:setSpawn(pos.x, pos.y, pos.z, pos.rot)
                pet:spawn()
                mobArg:entityAnimationPacket("shsm")
                mobArg:SetAutoAttackEnabled(true)
                mobArg:SetMagicCastingEnabled(true)
                mobArg:SetMobAbilityEnabled(true)
            end
        end)
    end
end

entity.onMobDeath = function(mob)
end

return entity
