-----------------------------------
-- 75 Era Guild Vendor Shops
-----------------------------------
require("scripts/globals/shop")
require("modules/module_utils")

local m = Module:new("era_guild_vendors")

xi = xi or {}

local lookupTable =
--[[
    -- Guild Name
    {"GuildType", "Zone", "NPCName", guildid, "DIALOG_NAME", opentime, closetime, holiday};

    --Holidays
    0 - Firesday
    1 - Earthsday
    2 - Watersday
    3 - Windsday
    4 - Iceday
    5 - Lightningsday
    6 - Lightsday
    7 - Darksday
]]

{
    -- Alchemist Guilds
    {"Alchemy", "Bastok_Mines", "Odoba", 5262, "ODOBA_SHOP_DIALOG", 8, 23, 5, 1},
    {"Alchemy", "Bastok_Mines", "Maymunah", 5262, "MAYMUNAH_SHOP_DIALOG", 8, 23, 5, 1},
    {"Alchemy", "Aht_Urhgan_Whitegate", "Wahraga", 60425, "WAHRAGA_SHOP_DIALOG", 8, 23, 5, xi.settings.main.ENABLE_TOAU},
    {"Alchemy", "Aht_Urhgan_Whitegate", "Gathweeda", 60425, "GATHWEEDA_SHOP_DIALOG", 8, 23, 5, xi.settings.main.ENABLE_TOAU},
    -- Bonecraft Guilds
    {"Bonecraft", "Windurst_Woods", "Shih_Tayuun", 514, "SHIH_TAYUUN_DIALOG", 8, 23, 3, 1},
    {"Bonecraft", "Windurst_Woods", "Retto-Marutto", 514, "RETTO_MARUTTO_DIALOG", 8, 23, 3, 1},
    -- Clothcraft Guilds
    {"Clothcraft", "Windurst_Woods", "Meriri", 5152, "MERIRI_DIALOG", 6, 21, 0, 1},
    {"Clothcraft", "Windurst_Woods", "Kuzah_Hpirohpon", 5152, "KUZAH_HPIROHPON_DIALOG", 6, 21, 0, 1},
    {"Clothcraft", "Selbina", "Tilala", 516, "CLOTHCRAFT_SHOP_DIALOG", 6, 21, 0, 1},
    {"Clothcraft", "Selbina", "Gibol", 516, "CLOTHCRAFT_SHOP_DIALOG", 6, 21, 0, 1},
    {"Clothcraft", "Al_Zahbi", "Taten-Bilten", 60430, "TATEN_BILTEN_SHOP_DIALOG", 6, 21, 0, xi.settings.main.ENABLE_TOAU},
    -- Cooking Guilds
    {"Cooking", "Windurst_Waters", "Chomo_Jinjahl", 530, "CHOMOJINJAHL_SHOP_DIALOG", 5, 20, 7, 1},
    {"Cooking", "Windurst_Waters", "Kopopo", 530, "KOPOPO_SHOP_DIALOG", 5, 20, 7, 1},
    -- Fishing Guilds
    {"Fishing", "Port_Windurst", "Babubu", 517, "BABUBU_SHOP_DIALOG", 3, 18, 5, 1},
    {"Fishing", "Selbina", "Graegham", 518, "FISHING_SHOP_DIALOG", 3, 18, 5, 1},
    {"Fishing", "Selbina", "Mendoline", 518, "FISHING_SHOP_DIALOG", 3, 18, 5, 1},
    {"Fishing", "Bibiki_Bay", "Mep_Nhapopoluko", 519, "MEP_NHAPOPOLUKO_DIALOG", 1, 18, 5, 1},
    {"Fishing", "Ship_bound_for_Selbina", "Rajmonda", 520, "RAJMONDA_SHOP_DIALOG", 1, 23, 5, 1},
    {"Fishing", "Ship_bound_for_Mhaura", "Lokhong", 521, "LOKHONG_SHOP_DIALOG", 1, 23, 5, 1},
    {"Fishing", "Ship_bound_for_Selbina_Pirates", "Rajmonda", 520, "RAJMONDA_SHOP_DIALOG", 1, 23, 5, 1},
    {"Fishing", "Ship_bound_for_Mhaura_Pirates", "Lokhong", 521, "LOKHONG_SHOP_DIALOG", 1, 23, 5, 1},
    {"Fishing", "Open_sea_route_to_Al_Zahbi", "Cehn_Teyohngo", 522, "CEHN_TEYOHNGO_SHOP_DIALOG", 1, 23, 5, xi.settings.main.ENABLE_TOAU},
    {"Fishing", "Open_sea_route_to_Mhaura", "Pashi_Maccaleh", 523, "PASHI_MACCALEH_SHOP_DIALOG", 1, 23, 5, xi.settings.main.ENABLE_TOAU},
    {"Fishing", "Silver_Sea_route_to_Nashmau", "Jidwahn", 524, "JIDWAHN_SHOP_DIALOG", 1, 23, 5, xi.settings.main.ENABLE_TOAU},
    {"Fishing", "Silver_Sea_route_to_Al_Zahbi", "Yahliq", 525, "YAHLIQ_SHOP_DIALOG", 1, 23, 5, xi.settings.main.ENABLE_TOAU},
    {"Fishing", "Aht_Urhgan_Whitegate", "Wahnid", 60426, "WAHNID_SHOP_DIALOG", 1, 18, 6, xi.settings.main.ENABLE_TOAU},
    -- Goldsmithing Guilds
    {"Goldsmithing", "Bastok_Markets", "Teerth", 5272, "TEERTH_SHOP_DIALOG", 8, 23, 4, 1},
    {"Goldsmithing", "Bastok_Markets", "Visala", 5272, "VISALA_SHOP_DIALOG", 8, 23, 4, 1},
    {"Goldsmithing", "Mhaura", "Celestina", 528, "GOLDSMITHING_GUILD", 8, 23, 4, 1},
    {"Goldsmithing", "Mhaura", "Yabby_Tanmikey", 528, "GOLDSMITHING_GUILD", 8, 23, 4, 1},
    {"Goldsmithing", "Al_Zahbi", "Bornahn", 60429, "BORNAHN_SHOP_DIALOG", 8, 23, 4, xi.settings.main.ENABLE_TOAU},
    -- Leathercraft Guilds
    {"Leathercraft", "Southern_San_dOria", "Kueh_Igunahmori", 529, "KUEH_IGUNAHMORI_DIALOG", 3, 18, 4, 1},
    {"Leathercraft", "Southern_San_dOria", "Cletae", 529, "CLETAE_DIALOG", 3, 18, 4, 1},
    -- Smithing Guilds
    {"Smithing", "Northern_San_dOria", "Doggomehr", 531, "DOGGOMEHR_SHOP_DIALOG", 8, 23, 2, 1},
    {"Smithing", "Northern_San_dOria", "Lucretia", 531, "LUCRETIA_SHOP_DIALOG", 8, 23, 2, 1},
    {"Smithing", "Mhaura", "Mololo", 532, "SMITHING_GUILD", 8, 23, 2, 1},
    {"Smithing", "Mhaura", "Kamilah", 532, "SMITHING_GUILD", 8, 23, 2, 1},
    {"Smithing", "Metalworks", "Vicious_Eye", 5332, "VICIOUS_EYE_SHOP_DIALOG", 8, 23, 2, 1},
    {"Smithing", "Metalworks", "Amulya", 5332, "AMULYA_SHOP_DIALOG", 8, 23, 2, 1},
    {"Smithing", "Al_Zahbi", "Ndego", 60427, "NDEGO_SHOP_DIALOG", 8, 23, 2, xi.settings.main.ENABLE_TOAU},
    -- Tenshodo Merchant
    {"Tenshodo", "Lower_Jeuno", "Akamafula", 60417, "AKAMAFULA_SHOP_DIALOG", 1, 23, 1, 1},
    {"Tenshodo", "Lower_Jeuno", "Amalasanda", 60432, "AMALASANDA_SHOP_DIALOG", 1, 23, 1, 1},
    {"Tenshodo", "Port_Bastok", "Jabbar", 60419, "TENSHODO_SHOP_OPEN_DIALOG", 1, 23, 4, 1},
    {"Tenshodo", "Port_Bastok", "Silver_Owl", 60420, "TENSHODO_SHOP_OPEN_DIALOG", 1, 23, 4, 1},
    {"Tenshodo", "Norg", "Achika", 60421, "ACHIKA_SHOP_DIALOG", 9, 23, 7, 1},
    {"Tenshodo", "Norg", "Chiyo", 60422, "CHIYO_SHOP_DIALOG", 9, 23, 7, 1},
    {"Tenshodo", "Norg", "Jirokichi", 60423, "JIROKICHI_SHOP_DIALOG", 9, 23, 7, 1},
    {"Tenshodo", "Norg", "Vuliaie", 60424, "VULIAIE_SHOP_DIALOG", 9, 23, 7, 1},
    {"Tenshodo", "Nashmau", "Tsutsuroon", 60431, "TSUTSUROON_SHOP_DIALOG", 1, 23, 7, xi.settings.main.ENABLE_TOAU},
    -- Woodworking Guilds
    {"Woodworking", "Carpenters_Landing", "Beugungel", 534, "BEUGUNGEL_SHOP_DIALOG", 5, 22, 0, 1},
    {"Woodworking", "Al_Zahbi", "Dehbi_Moshal", 60428, "DEHBI_MOSHAL_SHOP_DIALOG", 6, 21, 0, xi.settings.main.ENABLE_TOAU},
    {"Woodworking", "Northern_San_dOria", "Cauzeriste", 5132, "CAUZERISTE_SHOP_DIALOG", 6, 21, 0, 1},
    {"Woodworking", "Northern_San_dOria", "Chaupire", 5132, "CHAUPIRE_SHOP_DIALOG", 6, 21, 0, 1},
}

for _, shop in pairs(lookupTable) do
    if shop[9] == 1 then
        if shop[1] == 'Tenshodo' then
            local ID = require(string.format("scripts/zones/%s/IDs", shop[2]))
            m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3]),
            function(player, npc)
                if (player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD)) then
                    if (player:sendGuild(shop[4], shop[6], shop[7], shop[8])) then
                        player:showText(npc, ID.text[shop[5]])
                    end
                end
            end)
        else local ID = require(string.format("scripts/zones/%s/IDs", shop[2]))
            m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3]),
            function(player, npc)
                if (player:sendGuild(shop[4], shop[6], shop[7], shop[8])) then
                    player:showText(npc, ID.text[shop[5]])
                end
            end)
        end
    end
end

return m