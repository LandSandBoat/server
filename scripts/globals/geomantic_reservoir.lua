------------------------------
-- SOA Geomantic Reservoirs
------------------------------
require("scripts/globals/items")
require("scripts/globals/spell_data")
require("scripts/globals/zone")
------------------------------

xi = xi or {}
xi.geomanticReservoir = xi.geomanticReservoir or {}

-- This table was necessary in order for us to be able to print the name of the newly learned spell.
local geoSpellTable =
{
    [xi.magic.spell.GEO_POISON    ] = { xi.items.GEO_POISON     },
    [xi.magic.spell.GEO_VOIDANCE  ] = { xi.items.GEO_VOIDANCE   },
    [xi.magic.spell.GEO_PRECISION ] = { xi.items.GEO_PRECISION  },
    [xi.magic.spell.GEO_REGEN     ] = { xi.items.GEO_REGEN      },
    [xi.magic.spell.GEO_ATTUNEMENT] = { xi.items.GEO_ATTUNEMENT },
    [xi.magic.spell.GEO_FOCUS     ] = { xi.items.GEO_FOCUS      },
    [xi.magic.spell.GEO_BARRIER   ] = { xi.items.GEO_BARRIER    },
    [xi.magic.spell.GEO_REFRESH   ] = { xi.items.GEO_REFRESH    },
    [xi.magic.spell.GEO_CHR       ] = { xi.items.GEO_CHR        },
    [xi.magic.spell.GEO_MND       ] = { xi.items.GEO_MND        },
    [xi.magic.spell.GEO_FURY      ] = { xi.items.GEO_FURY       },
    [xi.magic.spell.GEO_INT       ] = { xi.items.GEO_INT        },
    [xi.magic.spell.GEO_AGI       ] = { xi.items.GEO_AGI        },
    [xi.magic.spell.GEO_POISON    ] = { xi.items.GEO_POISON     },
    [xi.magic.spell.GEO_FEND      ] = { xi.items.GEO_FEND       },
    [xi.magic.spell.GEO_VIT       ] = { xi.items.GEO_VIT        },
    [xi.magic.spell.GEO_DEX       ] = { xi.items.GEO_DEX        },
    [xi.magic.spell.GEO_ACUMEN    ] = { xi.items.GEO_ACUMEN     },
    [xi.magic.spell.GEO_STR       ] = { xi.items.GEO_STR        },
    [xi.magic.spell.GEO_SLOW      ] = { xi.items.GEO_SLOW       },
    [xi.magic.spell.GEO_TORPOR    ] = { xi.items.GEO_TORPOR     },
    [xi.magic.spell.GEO_SLIP      ] = { xi.items.GEO_SLIP       },
    [xi.magic.spell.GEO_LANGUOR   ] = { xi.items.GEO_LANGUOR    },
    [xi.magic.spell.GEO_PARALYSIS ] = { xi.items.GEO_PARALYSIS  },
    [xi.magic.spell.GEO_VEX       ] = { xi.items.GEO_VEX        },
    [xi.magic.spell.GEO_FRAILTY   ] = { xi.items.GEO_FRAILTY    },
    [xi.magic.spell.GEO_WILT      ] = { xi.items.GEO_WILT       },
    [xi.magic.spell.GEO_MALAISE   ] = { xi.items.GEO_MALAISE    },
    [xi.magic.spell.GEO_GRAVITY   ] = { xi.items.GEO_GRAVITY    },
    [xi.magic.spell.GEO_HASTE     ] = { xi.items.GEO_HASTE      },
    [xi.magic.spell.GEO_FADE      ] = { xi.items.GEO_FADE       },
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
