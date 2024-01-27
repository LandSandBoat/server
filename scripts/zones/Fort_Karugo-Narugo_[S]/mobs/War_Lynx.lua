-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: War Lynx
-- The Tigress Strikes Fight
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if
        mob:getID() == ID.mob.TIGRESS_STRIKES_WAR_LYNX and
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_ACCEPTED
    then
        player:setCharVar('WarLynxKilled', 1)
    end
end

return entity
