-----------------------------------
-- Jeuno Conquest
-- Make other nations' rank 1 items available for purchase
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("jeuno_conquest")

local settings =
{
    cost = 1, -- x1 original cost

    name = "Beetron",
    pos  = { -9.452, 9.000, -33.231, 27 }, -- !pos -9.452 9.000 -33.231 243
    area = "RuLude_Gardens",
    look = cbxi.util.look({
        race = xi.race.HUME_M,
        face = cbxi.face.A4,
        head = cbxi.model.MONK_ARTIFACT,
        body = cbxi.model.MONK_ARTIFACT,
        hand = cbxi.model.MONK_ARTIFACT,
        legs = cbxi.model.MONK_ARTIFACT,
        feet = cbxi.model.MONK_ARTIFACT,
    }),
    dialog =
    {
        START =
        {
            { emote = xi.emote.YES },
            "As a neutral ally, Jeuno can provide the full conquest offerings.",
            " However, please be aware of the increased cost of these items.",
        },
        CANNOT =
        {
            { emote = xi.emote.NO },
            "You do not have enough Conquest Points to purchase the %s."
        },
        PURCHASE =
        {
            { emote = xi.emote.YES },
            "I have deducted %u Conquest Points for the %s."
        },
    },
}

local conquestItem =
{
    [xi.nation.SANDORIA] =
    {
        { -- Rank 1
            { cost = 1000, lvl = 10, id = 17167, name = "Royal Archers Longbow"  },
            { cost = 1000, lvl = 10, id = 16544, name = "Royal Archers Sword"    },
            { cost = 1000, lvl = 10, id = 12510, name = "Royal Footmans Bandana" },
            { cost = 1000, lvl = 10, id = 12753, name = "Royal Footmans Gloves"  },
            { cost = 1000, lvl = 10, id = 13004, name = "Royal Footmans Boots"   },
            { cost = 1000, lvl = 10, id = 16691, name = "Royal Archers Cesti"    },
            { cost = 1000, lvl = 10, id = 13718, name = "Royal Footmans Tunic"   },
        },
        { -- Rank 2
            { cost = 2000, lvl = 18, id = 16852, name = "Royal Spearmans Spear"   },
            { cost = 2000, lvl = 10, id = 12630, name = "Royal Footmans Vest"     },
            { cost = 2000, lvl = 20, id = 12882, name = "Royal Footmans Trousers" },
            { cost = 2000, lvl = 20, id = 17367, name = "Royal Spearmans Horn"    },
            { cost = 2000, lvl = 20, id = 13045, name = "Royal Footmans Clogs"    },
        },
        { -- Rank 3
            { cost = 4000, lvl = 30, id = 16844, name = "Royal Squires Halberd"   },
            { cost = 4000, lvl = 30, id = 13104, name = "Royal Squires Collar"    },
            { cost = 4000, lvl = 30, id = 12431, name = "Royal Squires Helm"      },
            { cost = 4000, lvl = 30, id = 12687, name = "Royal Squires Mufflers"  },
            { cost = 4000, lvl = 30, id = 12943, name = "Royal Squires Sollerets" },
            { cost = 4000, lvl = 30, id = 16744, name = "Royal Squires Dagger"    },
            { cost = 4000, lvl = 30, id = 17150, name = "Royal Squires Mace"      },
            { cost = 4000, lvl =  1, id = 13495, name = "San d'Orian Ring"        },
        },
        { -- Rank 4
            { cost = 8000, lvl = 40, id = 16601, name = "Royal Swordsmans Blade"  },
            { cost = 8000, lvl = 40, id = 12559, name = "Royal Squires Chainmail" },
            { cost = 8000, lvl = 40, id = 12815, name = "Royal Squires Breeches"  },
            { cost = 8000, lvl = 40, id = 13719, name = "Royal Squires Robe"      },
            { cost = 8000, lvl = 40, id = 12336, name = "Royal Squires Shield"    },
        },
        { -- Rank 5
            { cost = 16000, lvl = 50, id = 16851, name = "R.K. Army Lance"  },
            { cost = 16000, lvl = 50, id = 16571, name = "T.K. Army Sword"  },
            { cost = 16000, lvl = 50, id = 12312, name = "R.K. Army Shield" },
            { cost = 16000, lvl = 50, id = 12313, name = "T.K. Army Shield" },
            { cost = 16000, lvl = 50, id = 13107, name = "R.K. Army Collar" },
            { cost = 16000, lvl = 50, id = 13105, name = "T.K. Army Collar" },
            { cost = 16000, lvl = 50, id = 12686, name = "R.K. Mufflers"    },
            { cost = 16000, lvl = 50, id = 12942, name = "R.K. Sollerets"   },
            { cost = 16000, lvl = 50, id = 13220, name = "R.K. Belt"        },
            { cost = 16000, lvl = 50, id = 13720, name = "R.K. Cloak"       },
        },
        { -- Rank 6
            { cost = 24000, lvl = 55, id = 13580, name = "Royal Army Mantle"       },
            { cost = 24000, lvl = 55, id = 13106, name = "Royal Guards Collar"     },
            { cost = 24000, lvl = 55, id = 12430, name = "Royal Knights Bascinet"  },
            { cost = 24000, lvl = 55, id = 13722, name = "Royal Knights Aketon"    },
            { cost = 24000, lvl = 55, id = 12558, name = "Royal Knights Chainmail" },
            { cost = 24000, lvl = 55, id = 12814, name = "Royal Knights Breeches"  },
            { cost = 24000, lvl = 55, id = 12321, name = "Royal Guards Shield"     },
            { cost = 24000, lvl = 55, id = 17067, name = "Royal Guards Rod"        },
            { cost = 24000, lvl = 55, id = 16599, name = "Royal Guards Sword"      },
            { cost = 24000, lvl = 55, id = 16805, name = "Royal Guards Fleuret"    },
        },
        { -- Rank 7
            { cost = 32000, lvl = 60, id = 15956, name = "Temple Knights Quiver" },
            { cost = 32000, lvl = 60, id = 16886, name = "Grand Knights Lance"   },
            { cost = 32000, lvl = 60, id = 13557, name = "Grand Knights Ring"    },
        },
        { -- Rank 8
            { cost = 40000, lvl = 65, id = 14013, name = "Grand Temple Knights Gauntlets" },
            { cost = 40000, lvl = 65, id = 14014, name = "Grand Temple Knights Bangles"   },
            { cost = 40000, lvl = 65, id = 13140, name = "Grand Temple Knights Collar"    },
        },
        { -- Rank 9
            { cost = 48000, lvl = 71, id = 16953, name = "Reserve Captains Greatsword" },
            { cost = 48000, lvl = 71, id = 17934, name = "Reserve Captains Pick"       },
            { cost = 48000, lvl = 71, id = 17458, name = "Reserve Captains Mace"       },
            { cost = 48000, lvl = 71, id = 16893, name = "Reserve Captains Lance"      },
        },
        { -- Rank 10
            --{ cost = 56000, lvl =  1, id = 14428, name = "Kingdom Aketon"     },
        },
    },

    [xi.nation.BASTOK] =
    {
        { -- Rank 1
            { cost = 1000, lvl = 10, id = 16433, name = "Legionnaires Knuckles" },
            { cost = 1000, lvl = 10, id = 17223, name = "Legionnaires Crossbow" },
            { cost = 1000, lvl = 10, id = 16648, name = "Legionnaires Axe"      },
            { cost = 1000, lvl = 10, id = 12509, name = "Legionnaires Cap"      },
            { cost = 1000, lvl = 10, id = 12752, name = "Legionnaires Mittens"  },
            { cost = 1000, lvl = 10, id = 13003, name = "Legionnaires Leggings" },
            { cost = 1000, lvl = 10, id = 17128, name = "Legionnaires Staff"    },
            { cost = 1000, lvl = 10, id = 16780, name = "Legionnaires Scythe"   },
        },
        { -- Rank 2
            { cost = 2000, lvl = 18, id = 17048, name = "Decurions Hammer"      },
            { cost = 2000, lvl = 10, id = 12629, name = "Legionnaires Harness"  },
            { cost = 2000, lvl = 20, id = 12881, name = "Legionnaires Subligar" },
            { cost = 2000, lvl = 20, id = 16745, name = "Decurions Dagger"      },
            { cost = 2000, lvl = 20, id = 12337, name = "Decurions Shield"      },
        },
        { -- Rank 3
            { cost = 4000, lvl = 30, id = 16712, name = "Centurions Axe"              },
            { cost = 4000, lvl = 10, id = 13098, name = "Republican Bronze Medal"     },
            { cost = 4000, lvl = 30, id = 12438, name = "Centurions Visor"            },
            { cost = 4000, lvl = 30, id = 12566, name = "Centurions Scale Mail"       },
            { cost = 4000, lvl = 30, id = 12694, name = "Centurions Finger Gauntlets" },
            { cost = 4000, lvl = 30, id = 12822, name = "Centurions Cuisses"          },
            { cost = 4000, lvl = 30, id = 12950, name = "Centurions Greaves"          },
            { cost = 4000, lvl = 30, id = 16806, name = "Centurions Sword"            },
            { cost = 4000, lvl = 30, id = 13830, name = "Legionnaires Circlet"        },
            { cost = 4000, lvl =  1, id = 13497, name = "Bastokan Ring"               },
        },
        { -- Rank 4
            { cost = 8000, lvl = 40, id = 16516, name = "Junior Musketeers Tuck"    },
            { cost = 8000, lvl = 40, id = 12422, name = "I.M. Armet"                },
            { cost = 8000, lvl = 40, id = 12678, name = "I.M. Gauntlets"            },
            { cost = 8000, lvl = 40, id = 12934, name = "I.M. Sabatons"             },
            { cost = 8000, lvl = 40, id = 13721, name = "I.M. Gambison"             },
            { cost = 8000, lvl = 40, id = 17283, name = "Junior Musketeers Chakram" },
        },
        { -- Rank 5
            { cost = 16000, lvl = 50, id = 16529, name = "Musketeers Sword"        },
            { cost = 16000, lvl = 30, id = 13099, name = "Republican Iron Medal"   },
            { cost = 16000, lvl = 50, id = 12550, name = "Iron Musketeers Cuirass" },
            { cost = 16000, lvl = 50, id = 12806, name = "Iron Musketeers Cuisses" },
            { cost = 16000, lvl = 50, id = 17129, name = "Musketeers Pole"         },
            { cost = 16000, lvl = 50, id = 17253, name = "Musketeer Gun"           },
        },
        { -- Rank 6
            { cost = 24000, lvl = 55, id = 13100, name = "Republican Mythril Medal" },
            { cost = 24000, lvl = 55, id = 13582, name = "Republican Army Mantle"   },
            { cost = 24000, lvl = 55, id = 16557, name = "M.C. Falchion"            },
            { cost = 24000, lvl = 55, id = 12304, name = "M.C. Shield"              },
            { cost = 24000, lvl = 55, id = 17151, name = "M.C. Rod"                 },
            { cost = 24000, lvl = 55, id = 13064, name = "I.M. Gorget"              },
        },
        { -- Rank 7
            { cost = 32000, lvl = 60, id = 15957, name = "Iron Musketeers Quiver"     },
            { cost = 32000, lvl = 60, id = 17807, name = "Gold Musketeers Uchigatana" },
            { cost = 32000, lvl = 60, id = 13558, name = "Gold Musketeers Ring"       },
        },
        { -- Rank 8
            { cost = 40000, lvl = 65, id = 14015, name = "Praefectuss Gloves"    },
            { cost = 40000, lvl = 65, id = 13880, name = "Presidential Hairpin"  },
            { cost = 40000, lvl = 65, id = 13141, name = "Republican Gold Medal" },
        },
        { -- Rank 9
            { cost = 48000, lvl = 71, id = 16799, name = "Senior Gold Musketeers Scythe"   },
            { cost = 48000, lvl = 71, id = 17457, name = "Senior Gold Musketeers Rod"      },
            { cost = 48000, lvl = 71, id = 18196, name = "Senior Gold Musketeers Axe"      },
            { cost = 48000, lvl = 71, id = 17655, name = "Senior Gold Musketeers Scimitar" },
        },
        { -- Rank 10 
            --{ cost = 56000, lvl =  1, id = 14429, name = "Republic Aketon"       },
        },
    },

    [xi.nation.WINDURST] =
    {
        { -- Rank 1
            { cost = 1000, lvl = 10, id = 17159, name = "Freeswords Bow"       },
            { cost = 1000, lvl = 10, id = 17028, name = "Freeswords Club"      },
            { cost = 1000, lvl = 10, id = 16442, name = "Freeswords Baghnakhs" },
            { cost = 1000, lvl = 10, id = 12915, name = "Freeswords Slops"     },
            { cost = 1000, lvl = 10, id = 17130, name = "Freeswords Staff"     },
        },
        { -- Rank 2
            { cost = 2000, lvl = 18, id = 17103, name = "Mercenarys Pole"       },
            { cost = 2000, lvl = 20, id = 12484, name = "Mercenarys Hachimaki"  },
            { cost = 2000, lvl = 20, id = 12653, name = "Mercenarys Gi"         },
            { cost = 2000, lvl = 20, id = 12719, name = "Mercenarys Tekko"      },
            { cost = 2000, lvl = 20, id = 12855, name = "Mercenarys Sitabaki"   },
            { cost = 2000, lvl = 20, id = 12975, name = "Mercenarys Kyahan"     },
            { cost = 2000, lvl = 20, id = 16746, name = "Mercenarys Knife"      },
            { cost = 2000, lvl = 20, id = 16930, name = "Mercenarys Greatsword" },
        },
        { -- Rank 3
            { cost = 4000, lvl = 30, id = 16776, name = "Mrc. Cpt. Scythe"   },
            { cost = 4000, lvl = 30, id = 12470, name = "Mrc. Cpt. Headgear" },
            { cost = 4000, lvl = 30, id = 12598, name = "Mrc. Cpt. Doublet"  },
            { cost = 4000, lvl = 30, id = 12726, name = "Mrc. Cpt. Gloves"   },
            { cost = 4000, lvl = 30, id = 12854, name = "Mrc. Cpt. Hose"     },
            { cost = 4000, lvl = 30, id = 12982, name = "Mrc. Cpt. Gaiters"  },
            { cost = 4000, lvl = 30, id = 16747, name = "Mrc. Cpt. Kukri"    },
            { cost = 4000, lvl = 30, id = 13221, name = "Mrc. Cpt. Belt"     },
            { cost = 4000, lvl =  1, id = 13496, name = "Windurstian Ring"   },
        },
        { -- Rank 4
            { cost = 8000, lvl = 40, id = 16463, name = "Combat Casters Dagger"    },
            { cost = 8000, lvl = 40, id = 17282, name = "Combat Casters Boomerang" },
            { cost = 8000, lvl = 10, id = 13101, name = "Green Scarf"              },
            { cost = 8000, lvl = 40, id = 12614, name = "Combat Casters Cloak"     },
            { cost = 8000, lvl = 40, id = 12743, name = "Combat Casters Mitts"     },
            { cost = 8000, lvl = 40, id = 12870, name = "Combat Casters Slacks"    },
            { cost = 8000, lvl = 40, id = 12998, name = "Combat Casters Shoes"     },
            { cost = 8000, lvl = 40, id = 16807, name = "Combat Casters Scimitar"  },
            { cost = 8000, lvl = 40, id = 16669, name = "Combat Casters Axe"       },
        },
        { -- Rank 5
            { cost = 16000, lvl = 50, id = 17082, name = "Tactician Magicians Wand"     },
            { cost = 16000, lvl = 30, id = 13102, name = "Paisley Scarf"                },
            { cost = 16000, lvl = 50, id = 12478, name = "Tactician Magicians Hat"      },
            { cost = 16000, lvl = 50, id = 12606, name = "Tactician Magicians Coat"     },
            { cost = 16000, lvl = 50, id = 12734, name = "Tactician Magicians Cuffs"    },
            { cost = 16000, lvl = 50, id = 12862, name = "Tactician Magicians Slops"    },
            { cost = 16000, lvl = 50, id = 12990, name = "Tactician Magicians Pigaches" },
            { cost = 16000, lvl = 50, id = 16810, name = "Tactician Magicians Espadon"  },
            { cost = 16000, lvl = 50, id = 16694, name = "Tactician Magicians Hooks"    },
        },
        { -- Rank 6
            { cost = 24000, lvl = 55, id = 13103, name = "Checkered Scarf"      },
            { cost = 24000, lvl = 55, id = 13581, name = "Federal Army Mantle"  },
            { cost = 24000, lvl = 55, id = 17094, name = "Wise Wizards Staff"   },
            { cost = 24000, lvl = 55, id = 16808, name = "Wise Wizards Bilbo"   },
            { cost = 24000, lvl = 55, id = 16809, name = "Wise Wizards Anelace" },
        },
        { -- Rank 7
            { cost = 32000, lvl = 60, id = 15958, name = "Combat Casters Quiver"       },
            { cost = 32000, lvl = 60, id = 12363, name = "Patriarch Protectors Shield" },
            { cost = 32000, lvl = 60, id = 13559, name = "Patriarch Protectors Ring"   },
        },
        { -- Rank 8
            { cost = 40000, lvl = 65, id = 14016, name = "Master Casters Mitts"     },
            { cost = 40000, lvl = 65, id = 14017, name = "Master Casters Bracelets" },
            { cost = 40000, lvl = 65, id = 13142, name = "Windurstian Scarf"        },
        },
        { -- Rank 9
            { cost = 48000, lvl = 71, id = 18145, name = "Master Casters Bow"       },
            { cost = 48000, lvl = 71, id = 17530, name = "Master Casters Pole"      },
            { cost = 48000, lvl = 71, id = 17508, name = "Master Casters Baghnakhs" },
            { cost = 48000, lvl = 71, id = 17617, name = "Master Casters Knife"     },
        },
        { -- Rank 10
            --{ cost = 56000, lvl =  1, id = 14430, name = "Federation Aketon" },
        },
    },
}

local rankCost =
{
    1000,
    2000,
    4000,
    8000,
    16000,
    24000,
    32000,
    40000,
    48000,
    56000,
}

local function delayMenu(player, menuNext)
    local menu = menuNext

    player:timer(200, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

local function buyFinish(player, npc, item)
    local itemCost = item.cost * settings.cost

    if player:getCP() < itemCost then
        cbxi.util.dialog(player, settings.dialog.CANNOT, settings.name, { [1] = item.name, npc = npc })
        return
    end

    if npcUtil.giveItem(player, item.id) then
        cbxi.util.dialog(player, settings.dialog.PURCHASE, settings.name, { [1] = itemCost, [2] = item.name, npc = npc })
        player:delCP(itemCost)
    end
end

local function buyItem(player, npc, item)
    local itemCost = item.cost * settings.cost

    delayMenu(player, {
        title   = string.format("Buy for %u Conquest Points?", itemCost),
        options =
        {
            {
                "No",
                function()
                end,
            },
            {
                "Yes",
                function()
                    buyFinish(player, npc, item)
                end,
            },
        }
    })
end

local function buyRank(player, npc, nationID, rankID, page)
    local base    = page * 5
    local options = {}

    if page == 0 then
        table.insert(options, {
            "None",
            function()
            end,
        })
    end

    for index = 1, 5 do
        local itemIndex = base + index

        if
            itemIndex <= #conquestItem[nationID][rankID] and
            conquestItem[nationID][rankID][itemIndex] ~= nil
        then
            local item = conquestItem[nationID][rankID][itemIndex]

            table.insert(options, {
                string.format("%s", item.name),
                function()
                    buyItem(player, npc, item)
                end,
            })
        end
    end

    if #conquestItem[nationID][rankID] > 5 then
        if page == 0 then
            table.insert(options, {
                "Next",
                function()
                    buyRank(player, npc, nationID, rankID, 1)
                end,
            })
        else
            table.insert(options, {
                "Previous",
                function()
                    buyRank(player, npc, nationID, rankID, 0)
                end,
            })
        end
    end

    delayMenu(player, {
        title   = "Select an item:",
        options = options
    })
end

local function buyNation(player, npc, nationID, page)
    local rank    = player:getRank(player:getNation())
    local base    = page * 5
    local options = {}

    if page == 0 then
        table.insert(options, {
            "None",
            function()
            end,
        })
    end

    for index = 1, 5 do
        local itemRank = base + index

        if itemRank <= rank then
            local itemCost = rankCost[itemRank] * settings.cost

            table.insert(options, {
                string.format("Rank %u (%s CP)", itemRank, itemCost),
                function()
                    buyRank(player, npc, nationID, itemRank, 0)
                end,
            })
        end
    end

    if rank > 5 then
        if page == 0 then
            table.insert(options, {
                "Next",
                function()
                    buyNation(player, npc, nationID, 1)
                end,
            })
        else
            table.insert(options, {
                "Previous",
                function()
                    buyNation(player, npc, nationID, 0)
                end,
            })
        end
    end

    delayMenu(player, {
        title   = "Select a rank:",
        options = options
    })
end

local function onTrigger(player, npc)
    cbxi.util.dialog(player, settings.dialog.START, settings.name, { npc = npc })

    delayMenu(player, {
        title   = fmt("Select a nation ({} Conquest Points):", player:getCP()),
        options =
        {
            {
                "None",
                function()
                end,
            },
            {
                "San d'Oria",
                function()
                    buyNation(player, npc, xi.nation.SANDORIA, 0)
                end,
            },
            {
                "Bastok",
                function()
                    buyNation(player, npc, xi.nation.BASTOK, 0)
                end,
            },
            {
                "Windurst",
                function()
                    buyNation(player, npc, xi.nation.WINDURST, 0)
                end,
            },
        },
    })
end

cbxi.util.liveReload(m, {
    [settings.area] =
    {
        {
            name      = settings.name,
            objtype   = xi.objType.NPC,
            look      = settings.look,
            x         = settings.pos[1],
            y         = settings.pos[2],
            z         = settings.pos[3],
            rotation  = settings.pos[4],
            onTrigger = onTrigger,
        },
    },
})

return m
