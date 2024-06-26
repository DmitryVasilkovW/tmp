script FileDeleter
	property directoryPath : missing value

	on initWithPath(path)
		set directoryPath to path
	end initWithPath

	on decodeUnicode(input)
		set inputAsString to input as string
		return do shell script "python3 /Users/dmitryvasilkov/IdeaProjects/Mac-automation-scripts/File-relatedScripts/DeletingAllScreenshotsAndRedFlagFilesFinalVersion/decoding.py " & quoted form of inputAsString
	end decodeUnicode

	on deleteFiles()
		set fileList to list folder directoryPath without invisibles

		repeat with fileName in fileList
			set filePath to directoryPath & "/" & fileName

			set fileTags to paragraphs of (do shell script "mdls -name kMDItemUserTags -raw " & quoted form of filePath)
			set decodedTags to my decodeUnicode(fileTags)

			if decodedTags contains "красный" then
				do shell script "mv " & quoted form of filePath & " ~/.Trash"
			end if
		end repeat

	end deleteFiles

	deleteFiles()


	on deleteFilesWithNewPath(path)
		my initWithPath(path)
		my deleteFiles()

	end deleteFilesWithNewPath

	on tagFilesWithOldPath()

		if directoryPath is missing value then
			display dialog "Error: folder path is not set."
			error number -128
		end if

	end tagFilesWithOldPath

end script


set deletere to FileDeleter
tell deletere to deleteFilesWithNewPath("/Users/dmitryvasilkov/Desktop/bimbim")
