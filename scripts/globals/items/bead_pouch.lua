-----------------------------------
-- ID: 6181
-- Beitetsu Parcel
-- Breaks up a Beitetsu Parcel
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    beads = math.random(3,15)
    target:addCurrency("escha_beads", beads)
	target:PrintToPlayer(string.format("You earn %i beads.", beads), xi.msg.channel.SYSTEM_3)
end

return item_object
