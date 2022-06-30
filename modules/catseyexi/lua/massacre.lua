-----------------------------------
-- CatsEyeXI 4th of July Massacre
-----------------------------------
local m = Module:new("massacre")

m:addOverride("xi.globals.items.air_rider.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.airborne.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.angelwing.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.datechochin.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.goshikitenge.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.ichinintousen_koma.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.konron_hassen.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.little_comet.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.marine_bliss.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.meifu_goma.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.mog_missile.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.muteppo.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.papillion.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.popstar.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.rengedama.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.slime_rocket.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

m:addOverride("xi.globals.items.spirit_masque.onItemUse", function(target)
    local deathChance = math.random(1, 10)
	
	if deathChance == 10 then
	    printf("Player will now die.")
		target:PrintToArea(string.format("%s just had a limb blown off playing with fireworks!", target:getName()), xi.msg.area.SYSTEM_2);
		target:injectActionPacket(6, 633, 0, 0, 0)
		target:setHP(0)
    else
        target:PrintToPlayer("Firework: In 2020, an estimated 15,600 people were hospitalized with injuries related to fireworks", 0xD)
	end	
end)

return m