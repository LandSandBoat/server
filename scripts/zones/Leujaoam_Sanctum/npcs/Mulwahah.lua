-----------------------------------
-- Area: Leujaoam Sanctum
-- NPC: Mulwahah
-- Assault: Orichalcum Survey
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    if
        player:hasItem(739, xi.inventoryLocation.TEMPITEMS) and -- Chunk of Orichalcum Ore
        instance:getStage() == 1 and
        instance:getProgress() == 0
    then
        player:messageSpecial(ID.text.MULWAHAH_FINISH)
        player:delItem(739, 1, xi.inventoryLocation.TEMPITEMS)
        player:timer(3000, function(player) player:messageSpecial(ID.text.MULWAHAH_FINISH + 1, 739) end)
        player:timer(6000, function(player) player:messageSpecial(ID.text.MULWAHAH_FINISH + 2) end)
        player:timer(7000, function(player) instance:setProgress(1) end)
    elseif not player:hasItem(605, xi.inventoryLocation.TEMPITEMS) then -- Pickaxe
        player:messageSpecial(ID.text.MULWAHAH_TAKE_THIS, 739)
        player:addTempItem(605)
        player:messageSpecial(ID.text.OBTAINED_TEMP_ITEM, 605)
    elseif instance:getStage() == 1 and instance:getProgress() == 1 then
        player:messageSpecial(ID.text.MULWAHAH_TAKE_THIS + 2)
    else
        player:messageSpecial(ID.text.MULWAHAH_TAKE_THIS - 1, 605)
    end
end

return entity
