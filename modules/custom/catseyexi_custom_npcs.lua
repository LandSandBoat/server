-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
require("modules/module_utils")
require("scripts/globals/shop")
require("scripts/zones/Aht_Urhgan_Whitegate/Zone")
-----------------------------------
local m = Module:new("catseyexi_custom_npcs")
m:setEnabled(true)

---------------------------------------------
--          AHT URHGAN WHITEGATE           --
---------------------------------------------
m:addOverride("xi.zones.Aht_Urhgan_Whitegate.Zone.onInitialize", function(zone)
    local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
    -- Call the zone's original function for onInitialize
    super(zone)
	
    local mnejing = zone:insertDynamicEntity({  -- sell pup attachments
        objtype = xi.objType.NPC,
        name = "Mnejing",
        look = 3030,
        x = -63.022,
        y = -6.000,
        z = -48.491,
        rotation = 70,
        widescan = 1,

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
		    local stock =
            {
		        9885,  82992,    -- Magniplug
		        9887,  82992,    -- Arcanoclutch
		        9071,  88920,    -- Resister II
		        9044,  88920,    -- Auto-Repair Kit III
		        9073,  88920,    -- Arcanic Cell II
		        9045,  88920,    -- Mana Tank III
		        2414, 185250,    -- Steam Jacket
		        2413, 185250,    -- Coiler
		        2347, 222300,    -- Reactive Shield
		        2348, 222300,    -- Tranquilizer
		        2349, 222300,    -- Turbo Charger
		        2350, 222300,    -- Schurzen
		        2351, 222300,    -- Dynamo 
		        2352, 222300,    -- Condenser
		        2353, 222300,    -- Optic Fiber
		        2354, 222300,    -- Economizer
            }
            player:PrintToPlayer("Buy now to make your puppet stronger", 0, npc:getPacketName())
			xi.shop.general(player, stock)
        end,
    })

    utils.unused(mnejing)
	
	local qm_hydroguage = zone:insertDynamicEntity({  -- since fishing is disabled, allow player to pickup hydroguage from ???
        objtype = xi.objType.NPC,
        name = "???",
        look = "0x0000340000000000000000000000000000000000",
        x = 22.277,
        y = 2.000,
        z = -122.709,
        rotation = 180,
        widescan = 1, 

        onTrade = function(player, npc, trade)
        end,

        onTrigger = function(player, npc)
            if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_ACCEPTED then
			    player:addItem(2341)
			    player:messageSpecial( ID.text.ITEM_OBTAINED, 2341 )
			end
        end,
    })
	
	utils.unused(qm_hydroguage)
	

end)

-----------------------------------
--         THRONE ROOM           --
-----------------------------------
m:addOverride("xi.zones.Throne_Room.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)
	local teodor = zone:insertDynamicEntity({
    objtype = xi.objType.NPC,
    name = "Teodor",
    look = 3103,
    x = -0.255,
    y = 0.000,
    z = -19.674,
    rotation = 180,
    widescan = 1,

    onTrade = function(player, npc, trade)
    end,

    onTrigger = function(player, npc)
    local stock =
        {
        6377, 100000,    -- Imperial Chair
        6378, 100000,    -- Decorative Chair 
        6379, 100000,    -- Ornate Stool
        6380, 100000,    -- Refined Chair
        6408, 100000,    -- Portable Container
        6411, 100000,    -- Chocobo Chair
        6409, 200000,    -- Ephramadian Throne
        6412, 200000,    -- Leaf Bench
        6413, 200000,    -- Astral Cube
        6410, 500000,    -- Shadow Throne
        }
        player:PrintToPlayer("Have a seat", 0, npc:getPacketName())
        xi.shop.general(player, stock)
    end,
    })

    utils.unused(teodor)

end)

return m
