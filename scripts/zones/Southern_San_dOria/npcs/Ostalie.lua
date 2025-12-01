-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ostalie
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LEATHER_BELT,          442, 3 },
        { xi.item.LIZARD_BELT,          2808, 3 },
        { xi.item.SILVER_BELT,         11618, 3 },
        { xi.item.CIRCLET,               166, 3 },
        { xi.item.ROBE,                  249, 3 },
        { xi.item.CUFFS,                 137, 3 },
        { xi.item.SLOPS,                 199, 3 },
        { xi.item.FLASK_OF_EYE_DROPS,   1698, 3 },
        { xi.item.ANTIDOTE,              228, 3 },
        { xi.item.FLASK_OF_ECHO_DROPS,   832, 3 },
        { xi.item.POTION,                546, 3 },
        { xi.item.ETHER,                2025, 3 },
		-- 🔥 Added Ninja Tools --
        { xi.item.SHIHEI,              	 101, 3 },
        { xi.item.SAIRUI_RAN,          	 101, 3 },
		{ xi.item.KAGINAWA,          	 101, 3 },
        { xi.item.JUSATSU,          	 101, 3 },
        { xi.item.KODOKU,              	 101, 3 },
        { xi.item.SHINOBI_TABI,        	 101, 3 },
		{ xi.item.SANJAKU_TENUGUI,     	 101, 3 },
        { xi.item.INOSHISHINOFUDA,     	 501, 3 },
        { xi.item.SHIKANOFUDA,         	 501, 3 },
        { xi.item.CHONOFUDA,             501, 3 },
		-- 🔥 Added Ninja Tools --
        { xi.item.PICKAXE,               208, 3 },
        { xi.item.HATCHET,               208, 3 },
		{ xi.item.SICKLE,                208, 3 },
    }

    -- Thief's tools.
    if GetNationRank(player:getNation()) >= 2 then -- Player nation rank 2 or 3.
        table.insert(stock, { xi.item.SET_OF_THIEFS_TOOLS, 2158, 3 })
    end

    -- Living Key.
    local sandyNationRank  = GetNationRank(xi.nation.SANDORIA)
    local bastokNationRank = GetNationRank(xi.nation.BASTOK)
    local windyNationRank  = GetNationRank(xi.nation.WINDURST)
    if
        (sandyNationRank == bastokNationRank and sandyNationRank == windyNationRank) or                       -- All 3 nations tied.
        (sandyNationRank ~= bastokNationRank and sandyNationRank ~= windyNationRank and sandyNationRank == 3) -- Nation not tied and nation last.
    then
        table.insert(stock, { xi.item.LIVING_KEY, 5520, 3 })
    end

    player:showText(npc, ID.text.OSTALIE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
