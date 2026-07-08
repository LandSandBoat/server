-----------------------------------
-- Area: Hazhalm Testing Grounds
-- NPC: Armoury Crate
-----------------------------------
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getLocalVar('[ein]tempCrate') == 0 then
        return
    end

    local function showTempItems(p)
        p:startEvent(5,
            npc:getLocalVar('[ein]tempItem1'),
            npc:getLocalVar('[ein]tempItem2'),
            npc:getLocalVar('[ein]tempItem3'),
            npc:getLocalVar('[ein]tempItem4'),
            npc:getLocalVar('[ein]tempItem5'),
            npc:getLocalVar('[ein]tempItem6'),
            xi.item.DUSTY_POTION, -- Retail always sends this item in the last 2 slots
            xi.item.DUSTY_POTION
        )
    end

    if npc:getLocalVar('opened') == 0 then
        local tempItems = xi.einherjar.getTempItems()

        for i = 1, 6 do
            npc:setLocalVar('[ein]tempItem' .. i, tempItems[i])
        end

        npcUtil.openCrate(npc, function()
            return true
        end)
    end

    showTempItems(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5 and option >= 1 and option <= 6 then
        local crateItem = npc:getLocalVar('[ein]tempItem' .. option)

        local quantity = bit.rshift(crateItem, 16)
        local itemId = bit.band(crateItem, 0xFFFF)

        if player:hasItem(itemId, xi.inv.TEMPITEMS) then
            return player:messageSpecial(ID.text.ALREADY_POSSESS_TEMP)
        else
            if player:addTempItem(itemId) then
                player:messageSpecial(ID.text.OBTAINS_TEMP_ITEM, itemId)
                npc:setLocalVar('[ein]tempItem' .. option, bit.bor(bit.lshift(quantity - 1, 16), itemId))
            end
        end
    end
end

return entity
