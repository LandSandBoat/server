-----------------------------------
-- CatsEyeXI ZNM_Spawn_Fix
-----------------------------------
require("scripts/globals/npc_util")
require("modules/module_utils")

local znm = Module:new("ZNM_Spawn_Fix")

-- Start Zone: Arrapago Reef (54)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Nuhn !pos -451 -7 389 54

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm4.onTrade", function(player, npc, trade)
    local arrapagoFixID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    if npcUtil.tradeHas(trade, 2596) and npcUtil.popFromQM(player, npc, arrapagoFixID.mob.NUHN) then -- Trade Rose Scampi
        player:confirmTrade()
        player:messageSpecial(arrapagoFixID.text.DRAWS_NEAR)
    end
end)

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm4.onTrigger", function(player, npc)
    local arrapagoFixID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    player:messageSpecial(arrapagoFixID.text.STIFLING_STENCH)
end)

----------------------------------------------------------------------------------------------------------------------------------------------------
-- Zareehkl !pos 176 -4 182 54

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm3.onTrade", function(player, npc, trade)
    local arrapagoReefID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    if npcUtil.tradeHas(trade, 2598) and npcUtil.popFromQM(player, npc, arrapagoReefID.mob.ZAREEHKL_THE_JUBILANT) then -- Trade Merrow No. 11 Molting
        player:confirmTrade()
        player:messageSpecial(arrapagoReefID.text.DRAWS_NEAR)
    end
end)

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm3.onTrigger", function(player, npc)
    local arrapagoReefID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    player:messageSpecial(arrapagoReefID.text.FLUTTERY_OBJECTS)
end)

----------------------------------------------------------------------------------------------------------------------------------------------------
-- Velionis !pos 311 -3 27 54

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm2.onTrade", function(player, npc, trade)
    local arrapagoReefID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    if npcUtil.tradeHas(trade, 2600) and npcUtil.popFromQM(player, npc, arrapagoReefID.mob.VELIONIS) then -- Trade Golden Teeth
        player:confirmTrade()
        player:messageSpecial(arrapagoReefID.text.DRAWS_NEAR)
    end
end)

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm2.onTrigger", function(player, npc)
    local arrapagoReefID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    player:messageSpecial(arrapagoReefID.text.GLITTERING_FRAGMENTS)
end)

---------------------------------------------------------------------------------------------------------------------------------------------------
-- Apkallu !pos 488 -1 166 54

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm1.onTrade", function(player, npc, trade)
    local arrapagoReefID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    if npcUtil.tradeHas(trade, 2601) and npcUtil.popFromQM(player, npc, arrapagoReefID.mob.LIL_APKALLU) then -- Trade Greenling
        player:confirmTrade()
        player:messageSpecial(arrapagoReefID.text.DRAWS_NEAR)
    end
end)

znm:addOverride("xi.zones.Arrapago_Reef.npcs.qm1.onTrigger", function(player, npc)
    local arrapagoReefID = zones[xi.zone.ARRAPAGO_REEF] -- ZONE 113
    player:messageSpecial(arrapagoReefID.text.SLIMY_TOUCH)
end)

----------------------------------------------------------------------------------------------------------------------------------------------------
-- End Zone: Arrapago Reef (54)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Start Zone: Bhaflau_Thickets (52)
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Lividroot_Amooshah !pos 334 -10 184 52 !additem 2578

znm:addOverride("xi.zones.Bhaflau_Thickets.npcs.qm1.onTrade", function(player, npc, trade)
    local bhaflauThicketsID = zones[xi.zone.BHAFLAU_THICKETS]
    if npcUtil.tradeHas(trade, 2578) and npcUtil.popFromQM(player, npc, bhaflauThicketsID.mob.LIVIDROOT_AMOOSHAH) then -- Trade Oily Blood
        player:confirmTrade()
        player:messageSpecial(bhaflauThicketsID.text.DRAWS_NEAR)
    end
end)

znm:addOverride("xi.zones.Bhaflau_Thickets.npcs.qm1.onTrigger", function(player, npc)
    local bhaflauThicketsID = zones[xi.zone.BHAFLAU_THICKETS]
    player:messageSpecial(bhaflauThicketsID.text.BLOOD_STAINS)
end)

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dea !pos -34 -32 481 52 !additem 2576

znm:addOverride("xi.zones.Bhaflau_Thickets.npcs.qm2.onTrade", function(player, npc, trade)
    local bhaflauThicketsID = zones[xi.zone.BHAFLAU_THICKETS]
    if npcUtil.tradeHas(trade, 2576) and npcUtil.popFromQM(player, npc, bhaflauThicketsID.mob.DEA) then -- Trade Olzhiryan Cactus
        player:confirmTrade()
        player:messageSpecial(bhaflauThicketsID.text.DRAWS_NEAR)
    end
end)

znm:addOverride("xi.zones.Bhaflau_Thickets.npcs.qm2.onTrigger", function(player, npc)
    local bhaflauThicketsID = zones[xi.zone.BHAFLAU_THICKETS]
    player:messageSpecial(bhaflauThicketsID.text.SHED_LEAVES)
end)

----------------------------------------------------------------------------------------------------------------------------------------------------
-- End Zone: Bhaflau_Thickets (52)
----------------------------------------------------------------------------------------------------------------------------------------------------
return znm
