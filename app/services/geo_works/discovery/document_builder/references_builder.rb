module GeoWorks
  module Discovery
    class DocumentBuilder
      class ReferencesBuilder
        attr_reader :geo_concern, :path

        def initialize(geo_concern, path)
          @geo_concern = geo_concern
          @path = path
        end

        # Builds service reference fields such as thumbnail and download url.
        # @param [AbstractDocument] discovery document
        def build(document)
          document.wxs_identifier = wxs_identifier
          build_metadata_refs(document)
          build_download_refs(document)
        end

        private

          # Builds metadata file references.
          # @param [AbstractDocument] discovery document
          def build_metadata_refs(document)
            document.fgdc = fgdc
            document.iso19139 = iso19139
            document.mods = mods
          end

          # Builds geospatial file download references.
          # @param [AbstractDocument] discovery document
          def build_download_refs(document)
            document.download = download
            document.url = url
            document.thumbnail = thumbnail
            document.wxs_identifier = wxs_identifier
            document.wms_path = wms_path
            document.wfs_path = wfs_path
          end

          # Returns the identifier to use with WMS/WFS/WCS services.
          # @return [String] wxs indentifier
          def wxs_identifier
            wxs.identifier
          end

          # Returns the wms server url.
          # @return [String] wms server url
          def wms_path
            wxs.wms_path
          end

          # Returns the wfs server url.
          # @return [String] wfs server url
          def wfs_path
            wxs.wfs_path
          end

          # Returns a url to access further descriptive information.
          # @return [String] work show page url
          def url
            path.to_s
          end

          # Returns a direct file download url
          # @return [String] direct file  url
          def download
            path.file_download
          end

          # Returns an FGDC metadata document download url
          # @return [String] FGDC metadata document url
          def fgdc
            path.metadata_download('FGDC')
          end

          # Returns an ISO19139 metadata document download url
          # @return [String] ISO19139 metadata document url
          def iso19139
            path.metadata_download('ISO19139')
          end

          # Returns an MODS metadata document download url
          # @return [String] MODS metadata document url
          def mods
            path.metadata_download('MODS')
          end

          # Returns a thumbnail file url
          # @return [String] thumbnail url
          def thumbnail
            path.thumbnail
          end

          def wxs
            @wxs ||= Wxs.new(geo_concern)
          end
      end
    end
  end
end
