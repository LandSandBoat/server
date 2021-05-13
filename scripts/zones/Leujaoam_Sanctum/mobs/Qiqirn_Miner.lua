-----------------------------------
-- Area: Leujaoam Sanctum
-- Mob: Qiqirn Miner
-- Assault: Orichalcum Survey
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
	-- TODO: mob:setStatus(xi.status.NPC)
end

entity.onMobRoam = function(mob)
	instance = mob:getInstance()

	if instance:getStage() == 1 and mob:getLocalVar("Stage") == 0 then
		-- TODO: mob:setStatus(xi.status.MOB)
		mob:setAnimation(1)
		mob:setSpeed(100)
		mob:setAggressive(true)
		mob:setLocalVar("Stage", 1)
	end
end

entity.onTrigger = function(player, npc)
end

entity.onMobDeath = function(mob, player)
end

return entity
