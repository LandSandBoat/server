-----------------------------------
-- SOA Geomantic Reservoirs
-----------------------------------
-----------------------------------

xi = xi or {}
xi.geomanticReservoir = xi.geomanticReservoir or {}

-- This table was necessary in order for us to be able to print the name of the newly learned spell.
local geoSpellTable =
{
    [xi.magic.spell.GEO_POISON    ] = { xi.item.GEO_POISON     },
    [xi.magic.spell.GEO_VOIDANCE  ] = { xi.item.GEO_VOIDANCE   },
    [xi.magic.spell.GEO_PRECISION ] = { xi.item.GEO_PRECISION  },
    [xi.magic.spell.GEO_REGEN     ] = { xi.item.GEO_REGEN      },
    [xi.magic.spell.GEO_ATTUNEMENT] = { xi.item.GEO_ATTUNEMENT },
    [xi.magic.spell.GEO_FOCUS     ] = { xi.item.GEO_FOCUS      },
    [xi.magic.spell.GEO_BARRIER   ] = { xi.item.GEO_BARRIER    },
    [xi.magic.spell.GEO_REFRESH   ] = { xi.item.GEO_REFRESH    },
    [xi.magic.spell.GEO_CHR       ] = { xi.item.GEO_CHR        },
    [xi.magic.spell.GEO_MND       ] = { xi.item.GEO_MND        },
    [xi.magic.spell.GEO_FURY      ] = { xi.item.GEO_FURY       },
    [xi.magic.spell.GEO_INT       ] = { xi.item.GEO_INT        },
    [xi.magic.spell.GEO_AGI       ] = { xi.item.GEO_AGI        },
    [xi.magic.spell.GEO_POISON    ] = { xi.item.GEO_POISON     },
    [xi.magic.spell.GEO_FEND      ] = { xi.item.GEO_FEND       },
    [xi.magic.spell.GEO_VIT       ] = { xi.item.GEO_VIT        },
    [xi.magic.spell.GEO_DEX       ] = { xi.item.GEO_DEX        },
    [xi.magic.spell.GEO_ACUMEN    ] = { xi.item.GEO_ACUMEN     },
    [xi.magic.spell.GEO_STR       ] = { xi.item.GEO_STR        },
    [xi.magic.spell.GEO_SLOW      ] = { xi.item.GEO_SLOW       },
    [xi.magic.spell.GEO_TORPOR    ] = { xi.item.GEO_TORPOR     },
    [xi.magic.spell.GEO_SLIP      ] = { xi.item.GEO_SLIP       },
    [xi.magic.spell.GEO_LANGUOR   ] = { xi.item.GEO_LANGUOR    },
    [xi.magic.spell.GEO_PARALYSIS ] = { xi.item.GEO_PARALYSIS  },
    [xi.magic.spell.GEO_VEX       ] = { xi.item.GEO_VEX        },
    [xi.magic.spell.GEO_FRAILTY   ] = { xi.item.GEO_FRAILTY    },
    [xi.magic.spell.GEO_WILT      ] = { xi.item.GEO_WILT       },
    [xi.magic.spell.GEO_MALAISE   ] = { xi.item.GEO_MALAISE    },
    [xi.magic.spell.GEO_GRAVITY   ] = { xi.item.GEO_GRAVITY    },
    [xi.magic.spell.GEO_HASTE     ] = { xi.item.GEO_HASTE      },
    [xi.magic.spell.GEO_FADE      ] = { xi.item.GEO_FADE       },
}

-- need to check if you have the indi spell before learning the geo spell
-- https://www.bg-wiki.com/ffxi/Geomantic_Reservoir
local indiSpellMap =
{
    [xi.magic.spell.GEO_POISON    ] = xi.magic.spell.INDI_POISON,
    [xi.magic.spell.GEO_VOIDANCE  ] = xi.magic.spell.INDI_VOIDANCE,
    [xi.magic.spell.GEO_PRECISION ] = xi.magic.spell.INDI_PRECISION,
    [xi.magic.spell.GEO_REGEN     ] = xi.magic.spell.INDI_REGEN,
    [xi.magic.spell.GEO_ATTUNEMENT] = xi.magic.spell.INDI_ATTUNEMENT,
    [xi.magic.spell.GEO_FOCUS     ] = xi.magic.spell.INDI_FOCUS,
    [xi.magic.spell.GEO_BARRIER   ] = xi.magic.spell.INDI_BARRIER,
    [xi.magic.spell.GEO_REFRESH   ] = xi.magic.spell.INDI_REFRESH,
    [xi.magic.spell.GEO_CHR       ] = xi.magic.spell.INDI_CHR,
    [xi.magic.spell.GEO_MND       ] = xi.magic.spell.INDI_MND,
    [xi.magic.spell.GEO_FURY      ] = xi.magic.spell.INDI_FURY,
    [xi.magic.spell.GEO_INT       ] = xi.magic.spell.INDI_INT,
    [xi.magic.spell.GEO_AGI       ] = xi.magic.spell.INDI_AGI,
    [xi.magic.spell.GEO_POISON    ] = xi.magic.spell.INDI_POISON,
    [xi.magic.spell.GEO_FEND      ] = xi.magic.spell.INDI_FEND,
    [xi.magic.spell.GEO_VIT       ] = xi.magic.spell.INDI_VIT,
    [xi.magic.spell.GEO_DEX       ] = xi.magic.spell.INDI_DEX,
    [xi.magic.spell.GEO_ACUMEN    ] = xi.magic.spell.INDI_ACUMEN,
    [xi.magic.spell.GEO_STR       ] = xi.magic.spell.INDI_STR,
    [xi.magic.spell.GEO_SLOW      ] = xi.magic.spell.INDI_SLOW,
    [xi.magic.spell.GEO_TORPOR    ] = xi.magic.spell.INDI_TORPOR,
    [xi.magic.spell.GEO_SLIP      ] = xi.magic.spell.INDI_SLIP,
    [xi.magic.spell.GEO_LANGUOR   ] = xi.magic.spell.INDI_LANGUOR,
    [xi.magic.spell.GEO_PARALYSIS ] = xi.magic.spell.INDI_PARALYSIS,
    [xi.magic.spell.GEO_VEX       ] = xi.magic.spell.INDI_VEX,
    [xi.magic.spell.GEO_FRAILTY   ] = xi.magic.spell.INDI_FRAILTY,
    [xi.magic.spell.GEO_WILT      ] = xi.magic.spell.INDI_WILT,
    [xi.magic.spell.GEO_MALAISE   ] = xi.magic.spell.INDI_MALAISE,
    [xi.magic.spell.GEO_GRAVITY   ] = xi.magic.spell.INDI_GRAVITY,
    [xi.magic.spell.GEO_HASTE     ] = xi.magic.spell.INDI_HASTE,
    [xi.magic.spell.GEO_FADE      ] = xi.magic.spell.INDI_FADE,
}

xi.geomanticReservoir.onTrigger = function(player, npc, geoSpell)
    -- TODO: According to BG-Wiki there is a sequence here that a player can proc '!!' and achieve a Geomancy skill-up.
    -- TODO: is there different messaging if you don't know the indi spell vs already having the geo spell?
    -- https://www.bg-wiki.com/ffxi/Geomantic_Reservoir
    local procEffectTime = math.random(230, 300)
    local indiSpell = indiSpellMap[geoSpell]

    if
        player:getMainJob() == xi.job.GEO and
        not player:hasSpell(geoSpell) and
        indiSpell and
        player:hasSpell(indiSpell)
    then
        player:startEvent(15000,  procEffectTime)
        -- TODO add skillup logic if player clicks at the time the proc happens
    else
        player:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
    end
end

xi.geomanticReservoir.onEventFinish = function(player, csid, geoSpell)
    if csid == 15000 then
        player:addSpell(geoSpell, { silentLog = true })
        player:messageSpecial(zones[player:getZoneID()].text.LEARNS_SPELL, geoSpellTable[geoSpell][1])
    end
end
