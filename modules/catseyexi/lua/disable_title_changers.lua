-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("disable_title_changers")

m:addOverride("xi.zones.Southern_San_dOria_[S].npcs.Tamba-Namba.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Lower_Jeuno.npcs.Tuh_Almobankha.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Mhaura.npcs.Willah_Maratahya.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Selbina.npcs.Yulon-Polon.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Port_Jeuno.npcs.Zuah_Lepahnyu.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Tavnazian_Safehold.npcs.Aligi-Kufongi.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Windurst_Walls.npcs.Burute-Sorute.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Windurst_Waters_[S].npcs.Cattah_Pamjah.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Kazham.npcs.Eron-Tomaron.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Koyol-Futenol.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Southern_San_dOria.npcs.Moozo-Koozo.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Norg.npcs.Quntsu-Nointsu.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Rabao.npcs.Shupah_Mujuuk.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

m:addOverride("xi.zones.Port_Bastok.npcs.Styi_Palneh.onTrigger", function(player, npc)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end)

return m 