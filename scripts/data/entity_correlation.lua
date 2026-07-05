-----------------------------------
-- Monster correlation system
-- https://wiki-ffo-jp.translate.goog/html/5472.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
-----------------------------------

xi = xi or {}
xi.data = xi.data or {}
xi.data.entityCorrelation = xi.data.entityCorrelation or {}

local column =
{
    STRONG_AGAINST        = 1,
    WEAK_AGAINST          = 2,
    KILLER_MOD            = 3,
    DAMAGE_MULTIPLIER_MOD = 4,
    DAMAGE_REDUCTION_MOD  = 5,
}

xi.data.entityCorrelation.dataTable =
{
    -- Aquan > Amorph > Bird
    [xi.ecosystem.AQUAN          ] = { xi.ecosystem.AMORPH,   xi.ecosystem.BIRD,     xi.mod.AQUAN_KILLER,    0,                            0                            },
    [xi.ecosystem.AMORPH         ] = { xi.ecosystem.BIRD,     xi.ecosystem.AQUAN,    xi.mod.AMORPH_KILLER,   0,                            0                            },
    [xi.ecosystem.BIRD           ] = { xi.ecosystem.AQUAN,    xi.ecosystem.AMORPH,   xi.mod.BIRD_KILLER,     0,                            0                            },

    -- Beast > Lizard > Vermin > Plantoid
    [xi.ecosystem.BEAST          ] = { xi.ecosystem.LIZARD,   xi.ecosystem.PLANTOID, xi.mod.BEAST_KILLER,    0,                            0                            },
    [xi.ecosystem.LIZARD         ] = { xi.ecosystem.VERMIN,   xi.ecosystem.BEAST,    xi.mod.LIZARD_KILLER,   0,                            0                            },
    [xi.ecosystem.VERMIN         ] = { xi.ecosystem.PLANTOID, xi.ecosystem.LIZARD,   xi.mod.VERMIN_KILLER,   0,                            0                            },
    [xi.ecosystem.PLANTOID       ] = { xi.ecosystem.BEAST,    xi.ecosystem.VERMIN,   xi.mod.PLANTOID_KILLER, 0,                            0                            },

    -- Arcana <=> Undead
    [xi.ecosystem.ARCANA         ] = { xi.ecosystem.UNDEAD,   xi.ecosystem.UNDEAD,   xi.mod.ARCANA_KILLER,   xi.mod.ARCANA_DMG_MULTIPLIER, xi.mod.ARCANA_RES_MULTIPLIER },
    [xi.ecosystem.UNDEAD         ] = { xi.ecosystem.ARCANA,   xi.ecosystem.ARCANA,   xi.mod.UNDEAD_KILLER,   xi.mod.UNDEAD_DMG_MULTIPLIER, xi.mod.UNDEAD_RES_MULTIPLIER },

    -- Demon <=> Dragon
    [xi.ecosystem.DEMON          ] = { xi.ecosystem.DRAGON,   xi.ecosystem.DRAGON,   xi.mod.DEMON_KILLER,    xi.mod.DEMON_DMG_MULTIPLIER,  xi.mod.DEMON_RES_MULTIPLIER  },
    [xi.ecosystem.DRAGON         ] = { xi.ecosystem.DEMON,    xi.ecosystem.DEMON,    xi.mod.DRAGON_KILLER,   xi.mod.DRAGON_DMG_MULTIPLIER, xi.mod.DRAGON_RES_MULTIPLIER },

    -- Others.
    [xi.ecosystem.UNCLASSIFIED   ] = { nil,                   nil,                   0,                      0,                            0                            },
    [xi.ecosystem.ARCHAIC_MACHINE] = { nil,                   nil,                   0,                      0,                            0                            },
    [xi.ecosystem.BEASTMEN       ] = { nil,                   nil,                   0,                      0,                            0                            },
    [xi.ecosystem.ELEMENTAL      ] = { nil,                   nil,                   0,                      0,                            0                            },
    [xi.ecosystem.EMPTY          ] = { nil,                   nil,                   xi.mod.EMPTY_KILLER,    0,                            0                            },
    [xi.ecosystem.HUMANOID       ] = { nil,                   nil,                   xi.mod.HUMANOID_KILLER, 0,                            0                            },
    [xi.ecosystem.LUMINIAN       ] = { nil,                   nil,                   xi.mod.LUMINIAN_KILLER, 0,                            0                            },
    [xi.ecosystem.LUMINION       ] = { nil,                   nil,                   xi.mod.LUMINION_KILLER, 0,                            0                            },
    [xi.ecosystem.SUPREME_BEINGS ] = { nil,                   nil,                   0,                      0,                            0                            },
    [xi.ecosystem.VORAGEAN       ] = { nil,                   nil,                   0,                      0,                            0                            },
    [xi.ecosystem.STRUCTURES     ] = { nil,                   nil,                   0,                      0,                            0                            },
    [xi.ecosystem.WEAPONS        ] = { nil,                   nil,                   0,                      0,                            0                            },
}

xi.data.entityCorrelation.getEcosystemStrongAgainst = function(checkedEcosystem)
    local ecosystem = xi.data.entityCorrelation.dataTable[checkedEcosystem][column.STRONG_AGAINST]

    return ecosystem
end

xi.data.entityCorrelation.getEcosystemWeakAgainst = function(checkedEcosystem)
    local ecosystem = xi.data.entityCorrelation.dataTable[checkedEcosystem][column.WEAK_AGAINST]

    return ecosystem
end

xi.data.entityCorrelation.getEcosystemKillerMod = function(checkedEcosystem)
    local modifier = xi.data.entityCorrelation.dataTable[checkedEcosystem][column.KILLER_MOD] or 0

    return modifier
end

xi.data.entityCorrelation.getEcosystemDamageMultiplierMod = function(checkedEcosystem)
    local modifier = xi.data.entityCorrelation.dataTable[checkedEcosystem][column.DAMAGE_MULTIPLIER_MOD] or 0

    return modifier
end

xi.data.entityCorrelation.getEcosystemDamageReductionMod = function(checkedEcosystem)
    local modifier = xi.data.entityCorrelation.dataTable[checkedEcosystem][column.DAMAGE_REDUCTION_MOD] or 0

    return modifier
end
