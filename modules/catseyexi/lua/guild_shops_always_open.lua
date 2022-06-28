-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
require("settings/main")
require("scripts/globals/shop")

local m = Module:new("guild_shops_always_open")

m:addOverride("xi.zones.Northern_San_dOria.npcs.Doggomehr.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Northern_San_dOria/IDs")
    if (player:sendGuild(531, 0, 24, 2)) then
        player:showText(npc, ID.text.DOGGOMEHR_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Northern_San_dOria.npcs.Gaudylox.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Northern_San_dOria/IDs")
    if (player:sendGuild(60418, 0, 24, 0)) then
        player:showText(npc, ID.text.GAUDYLOX_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Northern_San_dOria.npcs.Chaupire.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Northern_San_dOria/IDs")
    if (player:sendGuild(5132, 0, 24, 0)) then
        player:showText(npc, ID.text.CHAUPIRE_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Bastok_Markets.npcs.Visala.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Bastok_Markets/IDs")
    if (player:sendGuild(5272, 0, 24, 4)) then
        player:showText(npc, ID.text.VISALA_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Ship_bound_for_Mhaura_Pirates.npcs.Lokhong.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Ship_bound_for_Mhaura_Pirates/IDs")
    if player:sendGuild(521, 0, 24, 5) then
        player:showText(npc, ID.text.LOKHONG_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Silver_Sea_route_to_Nashmau.npcs.Jidwahn.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Silver_Sea_route_to_Nashmau/IDs")
    if (player:sendGuild(524, 0, 24, 5)) then
        player:showText(npc, ID.text.JIDWAHN_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Mhaura.npcs.Yabby_Tanmikey.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Mhaura/IDs")
    if (player:sendGuild(528, 0, 24, 4)) then
        player:showText(npc, ID.text.GOLDSMITHING_GUILD)
    end
end)

m:addOverride("xi.zones.Mhaura.npcs.Kamilah.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Mhaura/IDs")
    if (player:sendGuild(532, 0, 24, 2)) then
        player:showText(npc, ID.text.SMITHING_GUILD)
    end
end)

m:addOverride("xi.zones.Windurst_Waters.npcs.Kopopo.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Windurst_Waters/IDs")
    if (player:sendGuild(530, 0, 24, 7)) then
        player:showText(npc, ID.text.KOPOPO_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Selbina.npcs.Graegham.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Selbina/IDs")
    if player:sendGuild(5182, 0, 24, 5) then
        player:showText(npc, ID.text.FISHING_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Selbina.npcs.Mendoline.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Selbina/IDs")
    if player:sendGuild(5182, 0, 24, 5) then
        player:showText(npc, ID.text.FISHING_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Selbina.npcs.Tilala.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Selbina/IDs")
    if player:sendGuild(516, 0, 24, 0) then
        player:showText(npc, ID.text.CLOTHCRAFT_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Al_Zahbi.npcs.Taten-Bilten.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Al_Zahbi/IDs")
    if player:sendGuild(60430, 0, 24, 0) then
        player:showText(npc, ID.text.TATEN_BILTEN_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Al_Zahbi.npcs.Bornahn.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Al_Zahbi/IDs")
    if (player:sendGuild(60429, 0, 24, 4)) then
        player:showText(npc, ID.text.BORNAHN_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Al_Zahbi.npcs.Ndego.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Al_Zahbi/IDs")
    if player:sendGuild(60427, 0, 24, 2) then
        player:showText(npc, ID.text.NDEGO_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Al_Zahbi.npcs.Dehbi_Moshal.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Al_Zahbi/IDs")
    if player:sendGuild(60428, 0, 24, 0) then
        player:showText(npc, ID.text.DEHBI_MOSHAL_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Port_Bastok.npcs.Blabbivix.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Port_Bastok/IDs")
    if (player:sendGuild(60418, 0, 24, 3)) then
        player:showText(npc, ID.text.BLABBIVIX_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Port_Bastok.npcs.Silver_Owl.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Port_Bastok/IDs")
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60420, 0, 24, 4)) then
            player:showText(npc, ID.text.TENSHODO_SHOP_OPEN_DIALOG)
        end
    else
        player:startEvent(150, 1)
    end
end)

m:addOverride("xi.zones.Port_Bastok.npcs.Jabbar.onTrigger", function(player, npc)   
    local ID = require("scripts/zones/Port_Bastok/IDs")
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60419, 0, 24, 4)) then
            player:showText(npc, ID.text.TENSHODO_SHOP_OPEN_DIALOG)
        end
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP) == QUEST_ACCEPTED) then
        if (player:hasKeyItem(xi.ki.TENSHODO_APPLICATION_FORM)) then
            player:startEvent(152)
        else
            player:startEvent(151)
        end
    else
        player:startEvent(150)
    end
end)

m:addOverride("xi.zones.Open_sea_route_to_Mhaura.npcs.Pashi_Maccaleh.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Open_sea_route_to_Mhaura/IDs")
    if (player:sendGuild(523, 0, 24, 5)) then
        player:showText(npc, ID.text.PASHI_MACCALEH_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Open_sea_route_to_Al_Zahbi.npcs.Cehn_Teyohngo.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Open_sea_route_to_Al_Zahbi/IDs")
    if (player:sendGuild(522, 0, 24, 5)) then
        player:showText(npc, ID.text.CEHN_TEYOHNGO_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Port_Windurst.npcs.Babubu.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Port_Windurst/IDs")
    if (player:sendGuild(517, 0, 24, 5)) then
        player:showText(npc, ID.text.BABUBU_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Ship_bound_for_Mhaura.npcs.Lokhong.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Ship_bound_for_Mhaura/IDs")
    if (player:sendGuild(521, 0, 24, 5)) then
        player:showText(npc, ID.text.LOKHONG_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Bibiki_Bay.npcs.Mep_Nhapopoluko.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Bibiki_Bay/IDs")
    if (player:sendGuild(519, 0, 24, 5)) then
        player:showText(npc, ID.text.MEP_NHAPOPOLUKO_DIALOG)
    end
end)

m:addOverride("xi.zones.Southern_San_dOria.npcs.Kueh_Igunahmori.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Southern_San_dOria/IDs")
    if (player:sendGuild(529, 0, 24, 4)) then
        player:showText(npc, ID.text.KUEH_IGUNAHMORI_DIALOG)
    end
end)

m:addOverride("xi.zones.Lower_Jeuno.npcs.Akamafula.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Lower_Jeuno/IDs")
    if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        if player:sendGuild(60417, 0, 24, 1) then
            player:showText(npc, ID.text.AKAMAFULA_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end)

m:addOverride("xi.zones.Norg.npcs.Chiyo.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Norg/IDs")
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60422, 0, 24, 7)) then
            player:showText(npc, ID.text.CHIYO_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end)

m:addOverride("xi.zones.Norg.npcs.Jirokichi.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Norg/IDs")
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60423, 0, 24, 7)) then
            player:showText(npc, ID.text.JIROKICHI_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end)

m:addOverride("xi.zones.Norg.npcs.Achika.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Norg/IDs")
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60421, 0, 24, 7)) then
            player:showText(npc, ID.text.ACHIKA_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end)

m:addOverride("xi.zones.Norg.npcs.Vuliaie.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Norg/IDs")
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60424, 0, 24, 7)) then
            player:showText(npc, ID.text.VULIAIE_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end)

m:addOverride("xi.zones.Carpenters_Landing.npcs.Beugungel.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Carpenters_Landing/IDs")
    if (player:sendGuild(534, 0, 24, 0)) then
        player:showText(npc, ID.text.BEUGUNGEL_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Ship_bound_for_Selbina_Pirates.npcs.Rajmonda.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Ship_bound_for_Selbina_Pirates/IDs")
    if player:sendGuild(520, 0, 24, 5) then
        player:showText(npc, ID.text.RAJMONDA_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Windurst_Woods.npcs.Kuzah_Hpirohpon.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Windurst_Woods/IDs")
    if (player:sendGuild(5152, 0, 24, 0)) then
        player:showText(npc, ID.text.KUZAH_HPIROHPON_DIALOG)
    end
end)

m:addOverride("xi.zones.Windurst_Woods.npcs.Shih_Tayuun.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Windurst_Woods/IDs")
    if player:sendGuild(514, 0, 24, 3) then
        player:showText(npc, ID.text.SHIH_TAYUUN_DIALOG)
    end
end)

m:addOverride("xi.zones.Nashmau.npcs.Tsutsuroon.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Nashmau/IDs")
    if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60431, 0, 24, 7)) then
            player:showText(npc, ID.text.TSUTSUROON_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end)

m:addOverride("xi.zones.Bastok_Mines.npcs.Maymunah.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Bastok_Mines/IDs")
    if player:sendGuild(5262, 0, 24, 6) then
        player:showText(npc, ID.text.MAYMUNAH_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Ship_bound_for_Selbina.npcs.Rajmonda.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Ship_bound_for_Selbina/IDs")
    if (player:sendGuild(520, 0, 24, 5)) then
        player:showText(npc, ID.text.RAJMONDA_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Wahnid.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
    if (player:sendGuild(60426, 0, 24, 6)) then
        player:showText(npc, ID.text.WAHNID_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Gathweeda.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
    if player:sendGuild(60425, 0, 24, 5) then
        player:showText(npc, ID.text.GATHWEEDA_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Aht_Urhgan_Whitegate.npcs.Wahraga.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
    if (player:sendGuild(60425, 0, 24, 5)) then
        player:showText(npc, ID.text.WAHRAGA_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Silver_Sea_route_to_Al_Zahbi.npcs.Yahliq.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Silver_Sea_route_to_Al_Zahbi/IDs")
    if (player:sendGuild(525, 0, 24, 5)) then
        player:showText(npc, ID.text.YAHLIQ_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Windurst_Walls.npcs.Scavnix.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Windurst_Walls/IDs")
    if player:sendGuild(60418, 0, 24, 6) then
        player:showText(npc, ID.text.SCAVNIX_SHOP_DIALOG)
    end
end)

m:addOverride("xi.zones.Metalworks.npcs.Amulya.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Metalworks/IDs")
    if (player:sendGuild(5332, 0, 24, 2)) then
        player:showText(npc, ID.text.AMULYA_SHOP_DIALOG)
    end
end)

return m