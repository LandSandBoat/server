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

xi.geomanticReservoir.onTrigger = function(player, npc, geoSpell)
    -- TODO: According to BG-Wiki there is a sequence here that a player can proc '!!' and achieve a Geomancy skill-up.
    -- https://www.bg-wiki.com/ffxi/Geomantic_Reservoir
    local procEffectTime = math.random(230, 300)
    if player:getMainJob() == xi.job.GEO and not player:hasSpell(geoSpell) then
        player:startEvent(15000,  procEffectTime)
        -- TODO add skillup logic if player clicks at the time the proc happens
    else
        player:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
    end
end

xi.geomanticReservoir.onEventFinish = function(player, csid, geoSpell)
    if csid == 15000 then
        player:addSpell(geoSpell, true, true) -- Quiesce the baked in message from addSpell(), we prefer the one below.
        player:messageSpecial(zones[player:getZoneID()].text.LEARNS_SPELL, geoSpellTable[geoSpell][1])
    end
end
