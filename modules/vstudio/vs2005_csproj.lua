--
-- vs2005_csproj.lua
-- Generate a Visual Studio 2005+ C# project.
-- Copyright (c) Jess Perkins and the Premake project
--

	local p = premake
	p.vstudio.cs2005 = {}

	local vstudio = p.vstudio
	local cs2005 = p.vstudio.cs2005
	local dotnetbase = p.vstudio.dotnetbase
	local project = p.project
	local config = p.config
	local fileconfig = p.fileconfig
	local dotnet = p.tools.dotnet

	cs2005.elements = {}

	cs2005.elements.project = function (prj)
		return {
			dotnetbase.projectElement,
			dotnetbase.configurationsBeforeSdk,
			dotnetbase.importSdkProps,
			dotnetbase.projectProperties,
			dotnetbase.configurations,
			dotnetbase.applicationIcon,
			dotnetbase.references,
			dotnetbase.importSdkTargets,
		}
	end

	cs2005.elements.projectProperties = function (cfg)
		return {
			dotnetbase.outputType,
			dotnetbase.appDesignerFolder,
			dotnetbase.rootNamespace,
			dotnetbase.assemblyName,
			dotnetbase.netcore.targetFramework,
			dotnetbase.allowUnsafeBlocks,
			dotnetbase.bindingRedirects,
			dotnetbase.netcore.useWpf,
			dotnetbase.csversion,
			dotnetbase.projectConfigurations,
			dotnetbase.netcore.enableDefaultCompileItems,
		}
	end

	cs2005.elements.configuration = function ()
		return {
			dotnetbase.propertyGroup,
			dotnetbase.debugProps,
			dotnetbase.compilerProps,
			dotnetbase.additionalProps,
			dotnetbase.NoWarn,
			dotnetbase.documentationfile,
		}
	end

	cs2005.elements.configurationBeforeSdk = function ()
		-- https://github.com/dotnet/sdk/issues/980
		-- https://github.com/dotnet/msbuild/issues/1603

		-- 必须在导入 .NET SDK 前设置输出目录
		return {
			dotnetbase.propertyGroupWithoutPlatformTarget,
			dotnetbase.outputProps,
		}
	end

	function cs2005.generate(prj)
		dotnetbase.prepare(cs2005)
		dotnetbase.generate(prj)
	end

	function cs2005.targets(prj)
	end
