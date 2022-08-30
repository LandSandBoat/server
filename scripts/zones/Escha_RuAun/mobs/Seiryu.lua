-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Seiryu
-- Mobid: 17309981
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local lifePercent = mob:getHPP()
    local phase = mob:getLocalVar("phase")
	local hateReset = mob:getLocalVar("hateReset")
	
	if mob:getMobMod(xi.mobMod.TELEPORT_START) > 1 and hateReset == 0 then
        mob:setLocalVar("hateReset", 1)
	    mob:resetEnmity(target)
	    print("TELEPORTATIONNNNN!!!!")
	end
	
    -- hp phases defined here
    if lifePercent <= 100 and lifePercent >= 81 then
        mob:setLocalVar("phase", 1)
    end
	
    if lifePercent <= 80 and lifePercent >= 61 then
        mob:setLocalVar("phase", 2)
		mob:setLocalVar("hateReset", 0)
    end
    
	if lifePercent <= 60 and lifePercent >= 41 then
        mob:setLocalVar("phase", 3)
		mob:setLocalVar("hateReset", 0)
    end
	
    if lifePercent <= 40 and lifePercent >= 31 then
        mob:setLocalVar("phase", 1)
		mob:setLocalVar("hateReset", 0)
    end
	
    if lifePercent <= 30 and lifePercent >= 21 then
        mob:setLocalVar("phase", 2)
		mob:setLocalVar("hateReset", 0)
    end
    
	if lifePercent <= 20 and lifePercent >= 1 then
        mob:setLocalVar("phase", 3)
		mob:setLocalVar("hateReset", 0)
    end

 -- Set Phase-Specific Mods
   if phase == 1 then -- takes magic dmg
      	mob:addMod(xi.mod.UDMGPHYS, -10000)
      	mob:addMod(xi.mod.UDMGRANGE, -10000)
      	mob:addMod(xi.mod.UDMGBREATH, -10000)
      	mob:addMod(xi.mod.UDMGMAGIC, 0)
      	mob:addMod(xi.mod.PHYS_ABSORB, 100)
      	mob:addMod(xi.mod.MAGIC_ABSORB, 0)
      	mob:setMobMod(xi.mobMod.TELEPORT_CD, 15)
        mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
        mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
	elseif phase == 2 then -- takes ranged dmg
        print("PHASE 2 BEGINNING")
		mob:addMod(xi.mod.UDMGPHYS, -10000)
		mob:addMod(xi.mod.UDMGRANGE, 0)
		mob:addMod(xi.mod.UDMGBREATH, -10000)
		mob:addMod(xi.mod.UDMGMAGIC, -10000)
		mob:addMod(xi.mod.PHYS_ABSORB, 0)
        mob:addMod(xi.mod.MAGIC_ABSORB, 10000)
		mob:setMobMod(xi.mobMod.TELEPORT_CD, 15)
        mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
		mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
	elseif phase == 3 then -- takes melee dmg
        print("PHASE 3 BEGINNING")
		mob:addMod(xi.mod.UDMGPHYS, 0)
		mob:addMod(xi.mod.UDMGRANGE, -10000)
		mob:addMod(xi.mod.UDMGBREATH, -10000)
		mob:addMod(xi.mod.UDMGMAGIC, -10000)
		mob:addMod(xi.mod.MAGIC_ABSORB, 100)
		mob:addMod(xi.mod.PHYS_ABSORB, 0)
		mob:setMobMod(xi.mobMod.TELEPORT_CD, 15)
        mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
        mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
    elseif phase == 4 then -- ??? 
        print("PHASE 4 BEGINNING")
	end
end	

entity.onMobDeath = function(mob, player, isKiller)
end

return entity