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

m:addOverride("xi.zones.Southern_San_dOria.Zone.onInitialize", function(zone)
    super(zone)
	
    local twotents = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = " ",
        look = 1274,
        x = -0.154,
        y = -0.815,
        z = 32.812,
        rotation = 63,
    })	
	
    local hanabi = zone:insertDynamicEntity({  -- sell Fireworks
    objtype  = xi.objType.NPC,
    name     = "Hanabi",
    look     = 2357,
    x        = 0.011,
    y        = -3.000,
    z        = -30.094,
    rotation = 70,
    widescan = 1,
	
    onTrigger = function(player, npc)
        local stock =
        {
            4218,  1,    -- Air Rider
            4186,  1,    -- Airborne
            5441,  1,    -- Angelwing
            5361,  1,    -- Datechochin
            5725,  1,    -- Goshikitenge
            5532,  1,    -- Ichinintousen Koma
            4183,  1,    -- Konron Hassen
            4169,  1,    -- Little Comet
            5882,  1,    -- Marine Bliss
            4185,  1,    -- Meifu Goma
            5936,  1,    -- Mog Missile
            5360,  1,    -- Muteppo
            4257,  1,    -- Papillion 
		    4215,  1,    -- Popstar
            5884,  1,    -- Rengedama
            6186,  1,    -- Slime Rocket
            4253,  1,    -- Spirit Masque
        }

        player:PrintToPlayer("Becareful not to hurt yourself", 0, npc:getPacketName())
        xi.shop.general(player, stock)
    end,
    })
end)

return m