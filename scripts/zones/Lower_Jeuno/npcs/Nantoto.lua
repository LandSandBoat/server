-----------------------------------
-- Area: Lower Jeuno
--  NPC: Hunter (Nantoto)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
local huntsTable = 
{
    [1] = {"Tzee Xicu the Manifest", "DEITY_DEBUNKER"},
    [2] = {"Dark Ixion", "IXION_HORNBREAKER"},
    [3] = {"Verthandi", "VERTHANDI_ENSNARER"},
    [4] = {"Yilbegan", "YILBEGAN_HIDEFLAYER"},
    [5] = {"Sandworm", "SANDWORM_WRANGLER"},
    [6] = {"Boroka", "BOROKA_BELEAGUERER"},
    [7] = {"Fafnir", "FAFNIR_SLAYER"},
    [8] = {"Nidhogg", "NIDHOGG_SLAYER"},
    [9] = {"Battleclad_Chariot", "STAR_CHARIOTEER"},
    [10] = {"Diabolos_Heart", "NIGHTMARE_AWAKENER"},
    [11] = {"Lich C Magnus", "LICH_BANISHER"},
    [12] = {"Sandworm", "SANDWORM_WRANGLER"},
    [13] = {"King Vinegarroon", "VINEGAR_EVAPORATOR"},
    [14] = {"Serket", "SERKET_BREAKER"},
    [15] = {"Krabkatoa", "KRABKATOA_STEAMER"},
    [16] = {"Dynamis Lord", "LIFTER_OF_SHADOWS"},
    [17] = {"Steelfleece Baldarich", "THE_HORNSPLITTER"},
    [18] = {"Stray Mary", "MARYS_GUIDE"},
    [19] = {"Orcus", "ORCUS_TROPHY_HUNTER"},
    [20] = {"Proto Omega", "APOLLYON_RAVAGER"},
    [21] = {"Lord Ruthven", "RUTHVEN_ENTOMBER"},
    [22] = {"Gurfurlur the Menacing", "TROLL_SUBJUGATOR"},
    [23] = {"Aspidochelone", "ASPIDOCHELONE_SINKER"},
    [24] = {"Adamantoise", "TORTOISE_TORTURER"},
    [25] = {"Baron Vapula",	"HELLSBANE"},
    [26] = {"Xolotl", "XOLOTL_XTRAPOLATOR"},
    [27] = {"Tiamat", "TIAMAT_TROUNCER"},
    [28] = {"Ichorous Ire", "JELLYBANE"},
    [29] = {"Khimaira", "KHIMAIRA_CARVER"},
    [30] = {"King Behemoth", "BEHEMOTH_DETHRONER"},
    [31] = {"Behemoth", "BEHEMOTHS_BANE"},
    [32] = {"Lambton Worm", "LAMBTON_WORM_DESEGMENTER"},
    [33] = {"Taisaijin", "BYE_BYE_TAISAI"},
    [34] = {"Medusa", "GORGONSTONE_SUNDERER"},
    [35] = {"Voluptuous Vivian", "THE_VIVISECTOR"},
    [36] = {"Warchief Vatgit", "WARCHIEF_WRECKER"},
    [37] = {"Simurgh", "SIMURGH_POACHER"},
    [38] = {"Orcus", "ORCUS_TROPHY_HUNTER"},
    [39] = {"Absolute Virtue", "VIRTUOUS_SAINT"},
    [40] = {"Sippoy", "SIPPOY_CAPTURER"},
    [41] = {"Lambton Worm", "LAMBTON_WORM_DESEGMENTER"},
    [42] = {"Cactrot Rapido", "CACTROT_DESACELERADOR"},
    [43] = {"Orcus", "ORCUS_TROPHY_HUNTER"},
    [44] = {"Long-Bowed Chariot", "COMET_CHARIOTEER"},
    [45] = {"Armored Chariot", "SUN_CHARIOTEER"},
    [46] = {"Awd Goggie", "BOGEYDOWNER"},
    [47] = {"Hydra", "HYDRA_HEADHUNTER"},
    [48] = {"Cerberus", "CERBERUS_MUZZLER"},
    [49] = {"Oupire", "OUPIRE_IMPALER"},
    [50] = {"Jormungand", "WORLD_SERPENT_SLAYER"},
    [51] = {"Ash Dragon", "DRAGON_ASHER"},
    [52] = {"Morbolger", "MORBOLBANE"},
    [53] = {"Capricious Cassie", "CASSIENOVA"},
    [54] = {"Goliath", "GOLIATH_KILLER"},
    [55] = {"Long-Armed Chariot", "MOON_CHARIOTEER"},
    [56] = {"Overlord Bakgodek", "OVERLORD_OVERTHROWER"},
    [57] = {"Cemetery Cherry", "MON_CHERRY"},
    [58] = {"Vrtra", "VRTRA_VANQUISHER"},
    [59] = {"LambtonWorm", "LAMBTON_WORM_DESEGMENTER"},
    [60] = {"Proto-Ultima", "TEMENOS_LIBERATOR"},
    [61] = {"Kirin", "KIRIN_CAPTIVATOR"},
    [62] = {"Iratham", "IRATHAM_CAPTURER"},
    [63] = {"Orcus", "ORCUS_TROPHY_HUNTER"},
    [64] = {"Roc", "ROC_STAR"},
    [65] = {"Gulool Ja Ja", "SHINING_SCALE_RIFLER"},
    [66] = {"Rani", "RANI_DECROWNER"},
}
    if player:getCharVar("Hunt_Target") then
	    local timeElapsed = os.time() - player:getCharVar("Hunt_StartTime")
		printf(timeElapsed)
	    if (timeElapsed < 86400) then 

	    -- select random NM from the hunts table
        local randomHunt = math.random(1, 68)
	    local selectedHunt = huntsTable[randomHunt][1]
	    local selectedHuntTitle = "xi.title." .. huntsTable[randomHunt][2]
	    player:PrintToPlayer("This NPC is not functional yet!")
	    
        player:setCharVar("Hunt_StartTime", os.time())
	    player:setCharVar("Hunt_Target", randomHunt)
	    player:PrintToPlayer(string.format("Selected Hunt: %s", selectedHunt), 0xD)
	    player:PrintToPlayer(string.format("Required Title: %s", selectedHuntTitle), 0xD)
	else
        player:PrintToPlayer(string.format("Hunter: You already have a hunt in progress. You must hunt %s down or wait for your hunt to reset.", huntsTable[selectedHunt]), 0xD)
    end
end	
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
