if SERVER then
hook.Add( "OnGamemodeLoaded", "adminostartup", function()
admino.ApplyCreate( "fastapplysandbox", "client", "function" )
   end)
end

if CLIENT then
function fastapplysandbox()

	if ( !hook.Run( "SpawnMenuEnabled" ) ) then return end

	hook.Run( "PopulateToolMenu" )

	g_SpawnMenu = vgui.Create( "SpawnMenu" )

	if ( IsValid( g_SpawnMenu ) ) then
		g_SpawnMenu:SetVisible( false )
	end

	CreateContextMenu()

	hook.Run( "PostReloadToolsMenu" )

   end
end