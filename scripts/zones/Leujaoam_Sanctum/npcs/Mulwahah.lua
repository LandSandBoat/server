-----------------------------------
-- Area: Leujaoam Sanctum
-- NPC: Nulwahah
-- Assault: Orichalcum Survey
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    -- Player is handing in the ore to complete the Assault
    if
        xi.assault.hasTempItem(player, xi.items.CHUNK_OF_ORICHALCUM_ORE) and
        instance:getProgress() < 2
    then
        player:messageSpecial(ID.text.FOUND_SOME)
        player:queue(3000, function(playerArg1)
            playerArg1:messageSpecial(ID.text.LOOK_AT_IT_SHINE, xi.items.CHUNK_OF_ORICHALCUM_ORE)
            playerArg1:queue(3000, function(playerArg2)
                playerArg2:messageSpecial(ID.text.RUMORS_TRUE)
                instance:setProgress(2)
            end)
        end)
    end

    -- Player needs a new pickaxe
    if
        not xi.assault.hasTempItem(player, xi.items.PICKAXE)
    then
        player:messageSpecial(ID.text.TAKE_THIS, xi.items.CHUNK_OF_ORICHALCUM_ORE)
        npcUtil.giveTempItem(player, xi.items.PICKAXE)
    else
        -- Only give this dialogue if player doesn't have ore
        if not xi.assault.hasTempItem(player, xi.items.CHUNK_OF_ORICHALCUM_ORE) then
            player:messageSpecial(ID.text.GET_MOVING, xi.items.PICKAXE)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
