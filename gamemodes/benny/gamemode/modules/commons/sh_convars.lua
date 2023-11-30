
-- Meanings:								Default,	Min,	Max,	Replicated,	Archived, Hint
-- Replicated is Userinfo in Client.

CONVARS_SV = {}

CONVARS_SV["cam_override"]					= { "",			nil,	nil,	true,		false,	"X Y Z P Y R FOV" }
CONVARS_SV["cam_unlock"]					= { 0,			0,		1,		true,		false,	"First person (sort of)" }

CONVARS_SV["net_easyway"]					= { 0,			0,		1,		true,		false,	"Use a disgusting way of networking inventories for minimal desync." }


CONVARS_SV_GEN = {}
for i, v in pairs( CONVARS_SV ) do 
	CONVARS_SV_GEN[i] = CreateConVar( "benny_" .. i, v[1], (v[4] and FCVAR_REPLICATED or 0) + (v[5] and FCVAR_ARCHIVE or 0), v[5], v[2], v[3] )
end

function ConVarSV( name )
	return CONVARS_SV_GEN[name]
end

function ConVarSV_Bool( name )
	return ConVarSV( name ):GetBool()
end

function ConVarSV_String( name )
	return ConVarSV( name ):GetString()
end

function ConVarSV_Int( name )
	return ConVarSV( name ):GetInt()
end

function ConVarSV_Float( name )
	return ConVarSV( name ):GetFloat()
end

if CLIENT then -- CL CL CL

CONVARS_CL = {}

CONVARS_CL["hud_scale"]					= { 2,			1,		4,		false,		true,	"HUD integer scaling" }
CONVARS_CL["hud_tempactive"]			= { "benny",	nil,	nil,	false,		true,	"HUD color scheme temporary" }

CONVARS_CL["wep_toggleaim"]				= { 1,			0,		1,		true,		true,	"Hold or toggle to aim weapon." }

CONVARS_CL["wep_toolgun"]				= { "",			nil,	nil,	true,		true,	"Toolgun tool." }

CONVARS_CL_GEN = {}
for i, v in pairs( CONVARS_CL ) do 
	CONVARS_CL_GEN[i] = CreateConVar( "benny_" .. i, v[1], (v[4] and FCVAR_USERINFO or 0) + (v[5] and FCVAR_ARCHIVE or 0), v[5], v[2], v[3] )
end

function ConVarCL( name )
	return CONVARS_CL_GEN[name]
end

function ConVarCL_Bool( name )
	return ConVarCL( name ):GetBool()
end

function ConVarCL_String( name )
	return ConVarCL( name ):GetString()
end

function ConVarCL_Int( name )
	return ConVarCL( name ):GetInt()
end

function ConVarCL_Float( name )
	return ConVarCL( name ):GetFloat()
end

end -- CL end CL end CL end
