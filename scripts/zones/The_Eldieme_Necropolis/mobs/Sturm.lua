-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Sturm
-- Involved in Quest: A New Dawn (BST AF3)
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    mob:setMod(xi.mod.STORETP, 75) -- 8 hits to 1k tp
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ANewDawn_Event') == 4
    then
        player:setCharVar('ANewDawn_Event', 5)
    end

    if
        optParams.isKiller or
        optParams.noKiller
    then
        for i = ID.mob.TAIFUN, ID.mob.TROMBE do
            if GetMobByID(i):isSpawned() then
                DespawnMob(i)
            end
        end
    end
end

return entity
