<?php

namespace App\Http\Resources\Api;

use App\Models\OfficeZpaceBenefit;
use App\Models\OfficeZpacePhoto;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OfficeSpaceResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'slug' => $this->slug,
            'address' => $this->address,
            'duration' => $this->duration,
            'price' => $this->price,
            'thumbnail' => $this->thumbnail,
            'about' => $this->about,
            'city' => new CityResource($this->whenLoaded('city')),
            'photos' => OfficeZpacePhotoResource::collection($this->whenLoaded('photos')),
            'benefits' => OfficeZpaceBenefitResource::collection($this->whenLoaded('benefits')),
        ];
    }
}
