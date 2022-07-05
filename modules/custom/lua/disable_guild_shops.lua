require("modules/module_utils")
local m = Module:new("disable_guild_shops")

xi = xi or {}

local lookupTable = {
	{"Bastok_Markets","Teerth"},
	{"Bastok_Markets","Visala"},	
	{"Bastok_Mines","Odoba"},
	{"Bastok_Mines","Maymunah"},
	{"Metalworks","Amulya"},
	{"Metalworks","Vicious_Eye"},
	{"Mhaura","Mololo"},
	{"Mhaura","Kamilah"},
	{"Northern_San_dOria","Doggomehr"},
	{"Northern_San_dOria","Lucretia"},
	{"Northern_San_dOria","Cauzeriste"},
	{"Northern_San_dOria","Chaupire"},
	{"Selbina","Tilala"},
	{"Selbina","Gibol"},
	{"Southern_San_dOria","Cletae"},
	{"Southern_San_dOria","Kueh_Igunahmori"},
	{"Windurst_Waters","Chomo_Jinjahl"},
	{"Windurst_Waters", "Kopopo"},
	{"Windurst_Woods","Shih_Tayuun"},
	{"Windurst_Woods","Retto-Marutto"},
	{"Windurst_Woods","Tergil"},
	{"Windurst_Woods","Meriri"},
	{"Windurst_Woods","Kuzah_Hpirohpon"},	
	}

for _, shop in pairs(lookupTable) do
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[1], shop[2]),
    function(player, npc)
    end)
end

return m
