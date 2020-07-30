-----------------------------------
-- Area: Qu'Bia Arena
--   NM: Archlich Taber'quoan
-- Mission 5-1 BCNM Fight
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 32)
end

function onMobFight(mob, target)
    local BattleTime = mob:getBattleTime()
    if (BattleTime - mob:getLocalVar("RepopWarriors") > 30) then
        local warriorsSpawned = 0
        for warrior = mob:getID()+3, mob:getID()+6 do
            if (not GetMobByID(warrior):isSpawned() and warriorsSpawned < 2) then
                SpawnMob(warrior):updateEnmity(target)
                if (warriorsSpawned == 1) then
                    GetMobByID(warrior):stun(5000)
                end
                warriorsSpawned = warriorsSpawned + 1
            end
        end

        mob:setLocalVar("RepopWarriors", BattleTime)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.ARCHMAGE_ASSASSIN)
end
