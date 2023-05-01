-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Cavernous Maw
-- !pos 369 8 -227 98
-- Teleports Players to Sauromugue_Champaign
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign_[S]/IDs")
require("scripts/globals/maws")
require("scripts/globals/teleports")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- if the player has this maw teleport already, has an adventuring fellow, but does not have wotg adventuring fellow access, time to get it
    local hasMaw = player:hasTeleport(xi.teleport.type.PAST_MAW, 2)
    local bond = player:getFellowValue("bond")
    local wotgUnlock = player:getFellowValue("wotg_unlock")

    if
        hasMaw and
        bond ~= nil and
        wotgUnlock ~= nil and
        wotgUnlock ~= 1
    then
        local fellowParam   = xi.fellow_utils.getFellowParam(player)
        player:startEvent(265, 0, 23, 1743, 0, 0, 9568257, 0, fellowParam)
    else
        xi.maws.onTrigger(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 265 then
        local styleParam    = xi.fellow_utils.getStyleParam(player)
        local lookParam     = xi.fellow_utils.getLookParam(player)
        local fellowParam   = xi.fellow_utils.getFellowParam(player)

        player:updateEvent(0, 0, 1743, 0, 0, styleParam, lookParam, fellowParam)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 265 then
        player:messageSpecial(ID.text.CAN_SUMMON_FELLOW_WOTG)
        player:setFellowValue("wotg_unlock", 1)
        local mawDestination = { 366.858,   8.545, -228.861,  95, 120 }
        player:timer(500, function(playerArg)
            playerArg:setPos(unpack(mawDestination))
        end)
    else
        xi.maws.onEventFinish(player, csid, option)
    end
end

return entity
