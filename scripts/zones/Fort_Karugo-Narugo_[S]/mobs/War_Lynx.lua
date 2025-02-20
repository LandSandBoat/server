-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: War Lynx
-- The Tigress Strikes Fight
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        mob:getID() == ID.mob.TIGRESS_STRIKES_WAR_LYNX and
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == xi.questStatus.QUEST_ACCEPTED
    then
        player:setCharVar('WarLynxKilled', 1)
    end
end

return entity
