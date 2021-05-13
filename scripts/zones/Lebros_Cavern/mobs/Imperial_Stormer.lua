-----------------------------------
-- Area: Lebros Cavern
--  Mob: Imperial Stormer
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local assaultFood =
{
    [1] = 5142, -- Serving of Bison Steak
    [2] = 5166, -- Coeurl Sub
    [3] = 5207, -- Strip of Bison Jerky
    [4] = 4416, -- Bowl of Pea Soup
    [5] = 4356, -- Loaf of White Bread
}

local foodPoints = function(player, mob)
    for _, v in pairs(assaultFood) do
        if player:hasItem(v.item, xi.inventoryLocation.TEMPITEMS) then
            mob:setLocalVar("foodEaten", mob:getLocalVar("foodEaten") + v.point)
            player:setLocalVar("foodGiven", 0)
            player:delItem(v.item, 1, xi.inventoryLocation.TEMPITEMS)
            return v.point
        end
    end
    return 0
end

entity.onMobSpawn = function(mob)
	mob:setStatus(xi.status.NPC)
end

entity.onTrigger = function(player, mob)
	local instance = mob:getInstance()
	local points = foodPoints(player, mob)
	local MOB = instance:getEntity(bit.band(mob:getID(), 0xFFF), xi.objType.MOB)


	if points > 0 then
		if mob:getLocalVar("foodEaten") >= 7 and mob:getLocalVar("complete") == 0 then
			instance:setProgress(instance:getProgress() + 1)
			mob:setLocalVar("complete", 1)
			player:showText(mob, ID.text.FULL_HUNGRY)
		elseif mob:getLocalVar("complete") == 1 then
			player:showText(mob, ID.text.FULL_FED)
		else
			player:showText(mob, ID.text.STILL_HUNGRY_FED)
		end
	else
		if mob:getLocalVar("foodEaten") >= 7 then
			player:showText(mob, ID.text.FULL_HUNGRY)
		else
			player:showText(mob, ID.text.STILL_HUNGRY_TRIGGER)
		end
	end
end

entity.onMobDeath = function(mob, player, isKiller, firstCall)
end

return entity
