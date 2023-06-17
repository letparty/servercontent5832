if SERVER then
if table.IsEmpty( list.Get( "HaloVehicles" ) ) == false then
timer.Simple( 0.02, function()
function HALOV_Spawn_SENT( player, EntityName, tr )
if ( EntityName == nil ) then return end
if ( !gamemode.Call( "PlayerSpawnSENT", player, EntityName ) ) then return end

	local vStart = player:EyePos()
	local vForward = player:GetAimVector()

if ( !tr ) then

	local trace = {}
	trace.start = vStart
	trace.endpos = vStart + (vForward * 4096)
	trace.filter = player

	tr = util.TraceLine( trace )

end

	local entity = nil
	local PrintName = nil
	local sent = scripted_ents.GetStored( EntityName )
if ( sent ) then
            
	local sent = sent.t
	
if(sent.AdminOnly and !player:IsAdmin()) then
if admino.InternalServerGet( EntityName, player ) ~= false then
   return
   end
end

if admino.InternalServerGet( EntityName, player ) == true then
if player:IsAdmin() == false and player:IsSuperAdmin() == false then
   return
   end
end

	ClassName = EntityName

	entity = sent:SpawnFunction( player, tr )

	ClassName = nil

	PrintName = sent.PrintName

else

	local SpawnableEntities = list.Get( "HaloVehicles" )
if (!SpawnableEntities) then return end
	local EntTable = SpawnableEntities[ EntityName ]
if (!EntTable) then return end

if(EntTable.AdminOnly and !player:IsAdmin()) then
if admino.InternalServerGet( EntityName, player ) ~= false then
   return
   end
end

if admino.InternalServerGet( EntityName, player ) == true then
if player:IsAdmin() == false and player:IsSuperAdmin() == false then
   return
   end
end

	PrintName = EntTable.PrintName

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
if ( EntTable.NormalOffset ) then SpawnPos = SpawnPos + tr.HitNormal * EntTable.NormalOffset end

	entity = ents.Create( EntTable.ClassName )
		
entity:SetPos( SpawnPos )
entity:Spawn()
entity:Activate()

if ( EntTable.DropToFloor ) then
entity:DropToFloor()
   end
end

if ( IsValid( entity ) ) then
if ( IsValid( player ) ) then
	gamemode.Call( "PlayerSpawnedSENT", player, entity )
end

undo.Create("SENT")
undo.SetPlayer(player)
undo.AddEntity(entity)
if ( PrintName ) then
	undo.SetCustomUndoText( "Undone "..PrintName )
end
undo.Finish( "Scripted Entity ("..tostring( EntityName )..")" )

player:AddCleanup( "sents", entity )
entity:SetVar( "Player", player )

   end
end
concommand.Add( "halov_spawnsent", function( ply, cmd, args ) HALOV_Spawn_SENT( ply, args[1] ) end ) 

function HALOV_CCGiveSWEP( player, command, arguments )

if ( arguments[1] == nil ) then return end

	local swept = list.Get( "HaloVehicles.Weapons" );
	local swep;

for k,v in pairs(swept) do
if (v.ClassName==arguments[1]) then
	swep = v; break;
   end
end

if (swep == nil) then return end

if(swep.AdminOnly and !player:IsAdmin()) then
if admino.InternalServerGet( arguments[1], player ) ~= false then
   return
   end
end

if admino.InternalServerGet( arguments[1], player ) == true then
if player:IsAdmin() == false and player:IsSuperAdmin() == false then
   return
   end
end

if (StarGate.NotSpawnable(arguments[1],player,"swep")) then return end
if ( !gamemode.Call( "PlayerGiveSWEP", player, arguments[1], swep ) ) then return end

MsgAll( "Giving "..player:Nick().." a "..swep.ClassName.."\n" )
player:Give( swep.ClassName )

player:SelectWeapon( swep.ClassName )

end

concommand.Add( "halov_giveswep", HALOV_CCGiveSWEP )

--[[---------------------------------------------------------
	-- Give a swep.. duh.
-----------------------------------------------------------]]
function HALOV_Spawn_Weapon( Player, wepname, tr )

if ( wepname == nil ) then return end

	local swept = list.Get( "HaloVehicles.Weapons" );
	local swep;

for k,v in pairs(swept) do
if (v.ClassName==wepname) then
	swep = v; break;
   end
end

if ( swep == nil ) then return end

if(swep.AdminOnly and !player:IsAdmin()) then
if admino.InternalServerGet( wepname, player ) ~= false then
   return
   end
end

if admino.InternalServerGet( wepname, player ) == true then
if player:IsAdmin() == false and player:IsSuperAdmin() == false then
   return
   end
end

if ( !gamemode.Call( "PlayerSpawnSWEP", Player, wepname, swep ) ) then return end

if ( !tr ) then
	tr = Player:GetEyeTraceNoCursor()
end

if ( !tr.Hit ) then return end

	local entity = ents.Create( swep.ClassName )

if ( IsValid( entity ) ) then

entity:SetPos( tr.HitPos + tr.HitNormal * 32 )
entity:Spawn()

gamemode.Call( "PlayerSpawnedSWEP", Player, entity )

   end
end

concommand.Add( "halov_spawnswep", function( ply, cmd, args ) HALOV_Spawn_Weapon( ply, args[1] ) end )    
      end)
   end
end

if(CLIENT) then
timer.Simple( 0.02, function()
if table.IsEmpty( list.Get( "HaloVehicles" ) ) == false then
hook.Add( "HaloVehiclesTab", "AddEntityContent", function( pnlContent, tree, node )

	local Categorised = {}

	local SpawnableEntities = list.Get( "HaloVehicles" )
	
if ( SpawnableEntities ) then
for k, v in pairs( SpawnableEntities ) do

	v.SpawnName = k
if(v.Category == "Halo") then
   v.Category = "Other";
else
   v.Category = string.gsub(v.Category, "%Halo Vehicles: ", "") or "Other";
end
Categorised[ v.Category ] = Categorised[ v.Category ] or {}
table.insert( Categorised[ v.Category ], v )

   end
end
            
SpawnableEntities = list.Get( "HaloVehicles.Weapons" )
if ( SpawnableEntities ) then
for k, v in pairs( SpawnableEntities ) do

	v.SpawnName = k
    v.Category = "Weapons";
	Categorised[ v.Category ] = Categorised[ v.Category ] or {}
	table.insert( Categorised[ v.Category ], v )

   end
end


for CategoryName, v in SortedPairs( Categorised ) do

	local node = tree:AddNode( CategoryName, "iconshalo/" .. string.lower(CategoryName) .. ".png" )

node.DoPopulate = function( self )

if ( self.PropPanel ) then return end

self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
self.PropPanel:SetVisible( false )
self.PropPanel:SetTriggerSpawnlistChange( false )

for k, ent in SortedPairsByMemberValue( v, "PrintName" ) do
    local enttype = "halovehicle"
if(CategoryName == "Weapons") then
	enttype = "weapon";
end

	local adminonly = ent.AdminOnly or false

if admino.InternalClientGet( ent.ClassName ) ~= nil then
if admino.InternalClientGet( ent.ClassName ) == true then adminonly = true end
if admino.InternalClientGet( ent.ClassName ) == false then adminonly = false end
end

spawnmenu.CreateContentIcon(enttype, self.PropPanel, {
	nicename	= ent.PrintName or ent.ClassName,
	spawnname	= ent.ClassName,
	material	= "entities/" .. ent.ClassName .. ".vmt",
	admin		= adminonly,
    author		= ent.Author,
	info		= ent.Instructions,
		} )
	   end
    end

node.DoClick = function( self )

self:DoPopulate()
pnlContent:SwitchPanel( self.PropPanel )

   end
end

	local FirstNode = tree:Root():GetChildNode( 0 )
	
if ( IsValid( FirstNode ) ) then
FirstNode:InternalDoClick()
	         end
         end)
      end	  
   end)   
end

