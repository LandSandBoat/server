-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Dynamis Lord
-- Note: Mega Boss
-- Spawned by trading a Shrouded Bijou to the ??? in front of Castle Zvahl.
-----------------------------------
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    tpz.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = tpz.jsa.HUNDRED_FISTS, hpp = 95},
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = 95},
            {id = tpz.jsa.BLOOD_WEAPON, hpp = 95},
            {id = tpz.jsa.CHAINSPELL, hpp = 95},
        },
    })
end

entity.onMobFight = function(mob, target)
    local battleTime = mob:getBattleTime()

    for i = 0, 1 do
        local petId = ID.mob.YING + i
        local pet = GetMobByID(petId)

        if battleTime % 90 == 0 and battleTime >= 90 and not pet:isSpawned() then
            pet:setSpawn(-414.282, -44, 20.427)
            pet:spawn()
            pet:updateEnmity(target)
        end

        if pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
    player:addTitle(tpz.title.LIFTER_OF_SHADOWS)
    if isKiller then
        DespawnMob(ID.mob.YING)
        DespawnMob(ID.mob.YING + 1)
    end
end

return entity
