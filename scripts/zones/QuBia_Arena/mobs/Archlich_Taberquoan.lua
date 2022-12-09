-----------------------------------
-- Area: Qu'Bia Arena
--   NM: Archlich Taber'quoan
-- Mission 5-1 BCNM Fight
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 32)
end

entity.onMobFight = function(mob, target)
    local battleTime = mob:getBattleTime()

    if battleTime - mob:getLocalVar("RepopWarriors") > 30 then
        local warriorsSpawned = 0
        for warrior = mob:getID() + 3, mob:getID() + 6 do
            if not GetMobByID(warrior):isSpawned() and warriorsSpawned < 2 then
                SpawnMob(warrior):updateEnmity(target)
                if warriorsSpawned == 1 then
                    GetMobByID(warrior):stun(5000)
                end

                warriorsSpawned = warriorsSpawned + 1
            end
        end

        mob:setLocalVar("RepopWarriors", battleTime)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ARCHMAGE_ASSASSIN)
end

return entity
