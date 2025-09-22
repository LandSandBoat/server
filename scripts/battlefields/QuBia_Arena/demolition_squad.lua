-----------------------------------
-- Demolition Squad
-- Qu'Bia Arena BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.DEMOLITION_SQUAD,
    maxPlayers    = 6,
    levelCap      = 60,
    timeLimit     = utils.minutes(30),
    index         = 8,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.MOON_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
    armouryCrates =
    {
        qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 4,
        qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 9,
        qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 14,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 1,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 2,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 3,
            },

            {
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 5,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 6,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 7,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 8,
            },

            {
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 10,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 11,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 12,
                qubiaID.mob.NEPHIYL_RAMPARTBREACHER + 13,
            },
        },

        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
        superlink = true,
    },
}

content.loot =
{
    {
        { itemId = xi.item.MARINE_M_GLOVES, weight = 125 }, -- marine_m_gloves
        { itemId = xi.item.MARINE_F_GLOVES, weight = 125 }, -- marine_f_gloves
        { itemId = xi.item.WOOD_GAUNTLETS,  weight = 125 }, -- wood_gauntlets
        { itemId = xi.item.WOOD_GLOVES,     weight = 125 }, -- wood_gloves
        { itemId = xi.item.CREEK_M_MITTS,   weight = 125 }, -- creek_m_mitts
        { itemId = xi.item.CREEK_F_MITTS,   weight = 125 }, -- creek_f_mitts
        { itemId = xi.item.RIVER_GAUNTLETS, weight = 125 }, -- river_gauntlets
        { itemId = xi.item.DUNE_BRACERS,    weight = 125 }, -- dune_bracers
    },

    {
        { itemId = xi.item.RED_CHIP,    weight = 125 }, -- red_chip
        { itemId = xi.item.BLUE_CHIP,   weight = 125 }, -- blue_chip
        { itemId = xi.item.YELLOW_CHIP, weight = 125 }, -- yellow_chip
        { itemId = xi.item.GREEN_CHIP,  weight = 125 }, -- green_chip
        { itemId = xi.item.CLEAR_CHIP,  weight = 125 }, -- clear_chip
        { itemId = xi.item.PURPLE_CHIP, weight = 125 }, -- purple_chip
        { itemId = xi.item.WHITE_CHIP,  weight = 125 }, -- white_chip
        { itemId = xi.item.BLACK_CHIP,  weight = 125 }, -- black_chip
    },

    {
        { itemId = xi.item.NONE,          weight = 125 }, -- nothing
        { itemId = xi.item.MYTHRIL_INGOT, weight = 125 }, -- mythril_ingot
        { itemId = xi.item.EBONY_LOG,     weight = 125 }, -- ebony_log
        { itemId = xi.item.PETRIFIED_LOG, weight = 125 }, -- petrified_log
        { itemId = xi.item.AQUAMARINE,    weight = 125 }, -- aquamarine
        { itemId = xi.item.PAINITE,       weight = 125 }, -- painite
        { itemId = xi.item.CHRYSOBERYL,   weight = 125 }, -- chrysoberyl
        { itemId = xi.item.MOONSTONE,     weight = 125 }, -- moonstone
    },

    {
        { itemId = xi.item.NONE,                      weight = 625 }, -- nothing
        { itemId = xi.item.SCROLL_OF_RERAISE_II,      weight = 125 }, -- scroll_of_reraise_ii
        { itemId = xi.item.SCROLL_OF_FLARE,           weight = 125 }, -- scroll_of_flare
        { itemId = xi.item.SCROLL_OF_VALOR_MINUET_IV, weight = 125 }, -- scroll_of_valor_minuet_iv
    },

    {
        { itemId = xi.item.NONE,           weight = 700 }, -- nothing
        { itemId = xi.item.HI_POTION_P3,   weight =  75 }, -- hi-potion_+3
        { itemId = xi.item.HI_RERAISER,    weight = 150 }, -- hi-reraiser
        { itemId = xi.item.VILE_ELIXIR,    weight =  50 }, -- vile_elixir
        { itemId = xi.item.VILE_ELIXIR_P1, weight =  25 }, -- vile_elixir_+1
    },
}

return content:register()
