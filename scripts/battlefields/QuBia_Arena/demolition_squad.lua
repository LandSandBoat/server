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
        { item = xi.item.MARINE_M_GLOVES, weight = 125 }, -- marine_m_gloves
        { item = xi.item.MARINE_F_GLOVES, weight = 125 }, -- marine_f_gloves
        { item = xi.item.WOOD_GAUNTLETS,  weight = 125 }, -- wood_gauntlets
        { item = xi.item.WOOD_GLOVES,     weight = 125 }, -- wood_gloves
        { item = xi.item.CREEK_M_MITTS,   weight = 125 }, -- creek_m_mitts
        { item = xi.item.CREEK_F_MITTS,   weight = 125 }, -- creek_f_mitts
        { item = xi.item.RIVER_GAUNTLETS, weight = 125 }, -- river_gauntlets
        { item = xi.item.DUNE_BRACERS,    weight = 125 }, -- dune_bracers
    },

    {
        { item = xi.item.RED_CHIP,    weight = 125 }, -- red_chip
        { item = xi.item.BLUE_CHIP,   weight = 125 }, -- blue_chip
        { item = xi.item.YELLOW_CHIP, weight = 125 }, -- yellow_chip
        { item = xi.item.GREEN_CHIP,  weight = 125 }, -- green_chip
        { item = xi.item.CLEAR_CHIP,  weight = 125 }, -- clear_chip
        { item = xi.item.PURPLE_CHIP, weight = 125 }, -- purple_chip
        { item = xi.item.WHITE_CHIP,  weight = 125 }, -- white_chip
        { item = xi.item.BLACK_CHIP,  weight = 125 }, -- black_chip
    },

    {
        { item = xi.item.NONE,          weight = 125 }, -- nothing
        { item = xi.item.MYTHRIL_INGOT, weight = 125 }, -- mythril_ingot
        { item = xi.item.EBONY_LOG,     weight = 125 }, -- ebony_log
        { item = xi.item.PETRIFIED_LOG, weight = 125 }, -- petrified_log
        { item = xi.item.AQUAMARINE,    weight = 125 }, -- aquamarine
        { item = xi.item.PAINITE,       weight = 125 }, -- painite
        { item = xi.item.CHRYSOBERYL,   weight = 125 }, -- chrysoberyl
        { item = xi.item.MOONSTONE,     weight = 125 }, -- moonstone
    },

    {
        { item = xi.item.NONE,                      weight = 625 }, -- nothing
        { item = xi.item.SCROLL_OF_RERAISE_II,      weight = 125 }, -- scroll_of_reraise_ii
        { item = xi.item.SCROLL_OF_FLARE,           weight = 125 }, -- scroll_of_flare
        { item = xi.item.SCROLL_OF_VALOR_MINUET_IV, weight = 125 }, -- scroll_of_valor_minuet_iv
    },

    {
        { item = xi.item.NONE,           weight = 700 }, -- nothing
        { item = xi.item.HI_POTION_P3,   weight =  75 }, -- hi-potion_+3
        { item = xi.item.HI_RERAISER,    weight = 150 }, -- hi-reraiser
        { item = xi.item.VILE_ELIXIR,    weight =  50 }, -- vile_elixir
        { item = xi.item.VILE_ELIXIR_P1, weight =  25 }, -- vile_elixir_+1
    },
}

return content:register()
